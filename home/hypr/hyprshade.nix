{
  lib,
  pkgs,
  ...
}: let
  start_blue_light_filter_on = "21:00:00";
  end_blue_light_filter_on = "06:00:00";
in {
  home.packages = with pkgs; [
    hyprshade
  ];

  home.file.".config/hypr/hyprshade.toml".text =
    /*
    toml
    */
    ''
      [[shades]]
      name = "vibrance"
      default = true

      [[shades]]
      name = "blue-light-filter"
      start_time = ${start_blue_light_filter_on}
      end_time = ${end_blue_light_filter_on}

      # [[shades]]
      # name = "color-filter"
      # [shades.config]
      # type = "protanopia" # "protanopia", "deuteranopia", "tritanopia"
      # intensity = 1.0     # 0.0 - 1.0
    '';

  # systemd.user = {
  #   services.hyprshade = {
  #     Unit = {
  #       Description = "Apply screen filter";
  #     };
  #     Service = {
  #       Type = "oneshot";
  #       ExecStart = "${lib.getExe pkgs.hyprshade} auto";
  #     };
  #   };
  #   timers.hyprshade = {
  #     Unit = {
  #       Description = "Apply screen filter on schedule";
  #     };
  #     Timer = {
  #       OnCalendar = [
  #         "*-*-* ${start_blue_light_filter_on}"
  #         "*-*-* ${end_blue_light_filter_on}"
  #       ];
  #     };
  #     Install = {
  #       WantedBy = ["timers.target"];
  #     };
  #   };
  # };

  home.file.".config/hypr/shaders/blue-light-filter.glsl".text =
    /*
    glsl
    */
    ''
      // from https://github.com/hyprwm/Hyprland/issues/1140#issuecomment-1335128437

      precision highp float;
      varying vec2 v_texcoord;
      uniform sampler2D tex;

      const float temperature = 2600.0;
      const float temperatureStrength = 1.0;

      #define WithQuickAndDirtyLuminancePreservation
      const float LuminancePreservationFactor = 1.0;

      // function from https://www.shadertoy.com/view/4sc3D7
      // valid from 1000 to 40000 K (and additionally 0 for pure full white)
      vec3 colorTemperatureToRGB(const in float temperature) {
          // values from: http://blenderartists.org/forum/showthread.php?270332-OSL-Goodness&p=2268693&viewfull=1#post2268693
          mat3 m = (temperature <= 6500.0) ? mat3(vec3(0.0, -2902.1955373783176, -8257.7997278925690),
                                                  vec3(0.0, 1669.5803561666639, 2575.2827530017594),
                                                  vec3(1.0, 1.3302673723350029, 1.8993753891711275))
                                           : mat3(vec3(1745.0425298314172, 1216.6168361476490, -8257.7997278925690),
                                                  vec3(-2666.3474220535695, -2173.1012343082230, 2575.2827530017594),
                                                  vec3(0.55995389139931482, 0.70381203140554553, 1.8993753891711275));
          return mix(clamp(vec3(m[0] / (vec3(clamp(temperature, 1000.0, 40000.0)) + m[1]) + m[2]), vec3(0.0), vec3(1.0)),
                     vec3(1.0), smoothstep(1000.0, 0.0, temperature));
      }

      void main() {
          vec4 pixColor = texture2D(tex, v_texcoord);

          // RGB
          vec3 color = vec3(pixColor[0], pixColor[1], pixColor[2]);

          #ifdef WithQuickAndDirtyLuminancePreservation
              color *= mix(1.0, dot(color, vec3(0.2126, 0.7152, 0.0722)) / max(dot(color, vec3(0.2126, 0.7152, 0.0722)), 1e-5),
                           LuminancePreservationFactor);
          #endif

          color = mix(color, color * colorTemperatureToRGB(temperature), temperatureStrength);

          vec4 outCol = vec4(color, pixColor[3]);

          gl_FragColor = outCol;
      }
    '';

  home.file.".config/hypr/shaders/color-filter.glsl.mustache".text =
    /*
    glsl
    */
    ''
      // Color blind shader for hyprland.
      // From: https://godotshaders.com/shader/colorblindness-correction-shader/

      precision highp float;
      varying vec2 v_texcoord;
      uniform sampler2D tex;

      // Intensity of filter (1.0 - 0.0)
      const float intensity = {{#intensity}}{{.}}{{/intensity}}{{^intensity}}0.2{{/intensity}};

      // Enum for color correction type
      const int PROTANOPIA = 0;
      const int DEUTERANOPIA = 1;
      const int TRITANOPIA = 2;

      // Color correction type
      const int type = {{#type}}{{.}}{{/type}}{{^type}}PROTANOPIA{{/type}};

      void main() {
          vec4 pixColor = texture2D(tex, v_texcoord);

          float L = (17.8824 * pixColor.r) + (43.5161 * pixColor.g) + (4.11935 * pixColor.b);
          float M = (3.45565 * pixColor.r) + (27.1554 * pixColor.g) + (3.86714 * pixColor.b);
          float S = (0.0299566 * pixColor.r) + (0.184309 * pixColor.g) + (1.46709 * pixColor.b);

          float l, m, s;
          if (type == PROTANOPIA) {
              l = 0.0 * L + 2.02344 * M + -2.52581 * S;
              m = 0.0 * L + 1.0 * M + 0.0 * S;
              s = 0.0 * L + 0.0 * M + 1.0 * S;
          } else if (type == DEUTERANOPIA) {
              l = 1.0 * L + 0.0 * M + 0.0 * S;
              m = 0.494207 * L + 0.0 * M + 1.24827 * S;
              s = 0.0 * L + 0.0 * M + 1.0 * S;
          } else if (type == TRITANOPIA) {
              l = 1.0 * L + 0.0 * M + 0.0 * S;
              m = 0.0 * L + 1.0 * M + 0.0 * S;
              s = -0.395913 * L + 0.801109 * M + 0.0 * S;
          }

          vec4 error;
          error.r = (0.0809444479 * l) + (-0.130504409 * m) + (0.116721066 * s);
          error.g = (-0.0102485335 * l) + (0.0540193266 * m) + (-0.113614708 * s);
          error.b = (-0.000365296938 * l) + (-0.00412161469 * m) + (0.693511405 * s);
          error.a = 1.0;
          vec4 diff = pixColor - error;
          vec4 correction;
          correction.r = 0.0;
          correction.g = (diff.r * 0.7) + (diff.g * 1.0);
          correction.b = (diff.r * 0.7) + (diff.b * 1.0);
          correction = pixColor + correction;
          correction.a = pixColor.a * intensity;

          gl_FragColor = vec4(correction);
      }
    '';

  home.file.".config/hypr/shaders/invert-colors.glsl".text =
    /*
    glsl
    */
    ''
      precision highp float;
      varying vec2 v_texcoord;
      uniform sampler2D tex;

      void main() {
          vec4 pixColor = texture2D(tex, v_texcoord);
          gl_FragColor = vec4(1.0 - pixColor.r, 1.0 - pixColor.g, 1.0 - pixColor.b, pixColor.a);
      }
    '';

  home.file.".config/hypr/shaders/vibrance.glsl".text =
    /*
    glsl
    */
    ''
      // from https://github.com/hyprwm/Hyprland/issues/1140#issuecomment-1614863627

      precision highp float;
      varying vec2 v_texcoord;
      uniform sampler2D tex;

      // see https://github.com/CeeJayDK/SweetFX/blob/a792aee788c6203385a858ebdea82a77f81c67f0/Shaders/Vibrance.fx#L20-L30
      const vec3 VIB_RGB_BALANCE = vec3(1.0, 1.0, 1.0);
      const float VIB_VIBRANCE = 0.15;

      const vec3 VIB_coeffVibrance = VIB_RGB_BALANCE * -VIB_VIBRANCE;

      void main() {
          vec4 pixColor = texture2D(tex, v_texcoord);
          vec3 color = vec3(pixColor[0], pixColor[1], pixColor[2]);

          // vec3 VIB_coefLuma = vec3(0.333333, 0.333334, 0.333333); // was for `if VIB_LUMA == 1`
          vec3 VIB_coefLuma = vec3(0.212656, 0.715158, 0.072186); // try both and see which one looks nicer.

          float luma = dot(VIB_coefLuma, color);

          float max_color = max(color[0], max(color[1], color[2]));
          float min_color = min(color[0], min(color[1], color[2]));

          float color_saturation = max_color - min_color;

          vec3 p_col = vec3(vec3(vec3(vec3(sign(VIB_coeffVibrance) * color_saturation) - 1.0) * VIB_coeffVibrance) + 1.0);

          pixColor[0] = mix(luma, color[0], p_col[0]);
          pixColor[1] = mix(luma, color[1], p_col[1]);
          pixColor[2] = mix(luma, color[2], p_col[2]);

          gl_FragColor = pixColor;
      }
    '';
}
