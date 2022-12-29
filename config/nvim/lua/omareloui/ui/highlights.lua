local c = require "omareloui.ui.palette"
local set = vim.api.nvim_set_hl

M = {}

M.general = function()
  set(0, "Comment", { default = true, italic = true })
  set(0, "NonText", { fg = c.surface1 })

  set(0, "TabLine", { bg = c.overlay1, fg = "gray", italic = true })
  set(0, "TabLineFill", { default = true, bg = c.overlay1 })
  set(0, "TabLineSel", { default = true, fg = "white", bold = true })

  set(0, "CursorLine", { default = true, bg = c.overlay0 })
  set(0, "CursorColumn", { default = true, bg = c.overlay0 })
  set(0, "CursorMatchWord", { bg = c.surface0, underline = true })
end

M.lsp = function()
  set(0, "DiagnosticHint", { fg = c.purple })
  set(0, "DiagnosticError", { fg = c.red })
  set(0, "DiagnosticWarn", { fg = c.yellow })
  set(0, "DiagnosticInformation", { fg = c.green })
  set(0, "LspSignatureActiveParameter", { fg = c.black, bg = c.green })
end

M.cmp = function()
  set(0, "CmpItemMenu", { fg = c.subtext0 })
end

M.indent_backline = function()
  set(0, "IndentBlanklineChar", { fg = c.surface1 })
  set(0, "IndentBlanklineSpaceChar", { fg = c.surface0 })
  set(0, "IndentBlanklineContextChar", { fg = c.surface2 })
  set(0, "IndentBlanklineContextStart", { fg = c.surface0 })
end

M.gitsings = function()
  set(0, "DiffAdd", { fg = c.green })
  set(0, "DiffAdded", { fg = c.green })
  set(0, "DiffChange", { fg = c.blue })
  set(0, "DiffChangeDelete", { fg = c.red })
  set(0, "DiffModified", { fg = c.orange })
  set(0, "DiffDelete", { fg = c.red })
  set(0, "DiffRemoved", { fg = c.red })
end

M.lspsaga = function()
  -- code action
  set(0, "LspSagaCodeActionTitle", { fg = c.orange, bold = true })
  set(0, "LspSagaCodeActionBorder", { fg = c.purple })
  set(0, "LspSagaCodeActionTrunCateLine", { link = "LspSagaCodeActionBorder" })
  set(0, "LspSagaCodeActionContent", { fg = c.light_green, bold = true })
  -- finder
  set(0, "LspSagaLspFinderBorder", { fg = c.blue })
  set(0, "LspSagaAutoPreview", { fg = c.blue })
  set(0, "LspSagaFinderSelection", { fg = c.green, bold = true })
  set(0, "TargetFileName", { fg = c.light_orange })
  set(0, "FinderParam", { fg = c.purple, bg = c.base, bold = true })
  set(0, "FinderVirtText", { fg = c.red })
  set(0, "DefinitionsIcon", { fg = c.yellow })
  set(0, "Definitions", { fg = c.purple, bold = true })
  set(0, "DefinitionCount", { link = "Title" })
  set(0, "ReferencesIcon", { fg = c.yellow })
  set(0, "References", { fg = c.purple, bold = true })
  set(0, "ReferencesCount", { link = "Title" })
  set(0, "ImplementsIcon", { fg = c.yellow })
  set(0, "Implements", { fg = c.purple, bold = true })
  set(0, "ImplementsCount", { link = "Title" })
  --finder spinner
  set(0, "FinderSpinnerBorder", { fg = c.blue })
  set(0, "FinderSpinnerTitle", { fg = c.pink, bold = true })
  set(0, "FinderSpinner", { fg = c.pink, bold = true })
  set(0, "FinderPreviewSearch", { link = "Search" })
  -- definition
  set(0, "DefinitionBorder", { fg = c.light_blue })
  set(0, "DefinitionArrow", { fg = c.red })
  set(0, "DefinitionSearch", { link = "Search" })
  set(0, "DefinitionFile", { bg = c.base })
  -- hover
  set(0, "LspSagaHoverBorder", { fg = c.yellow })
  set(0, "LspSagaHoverTrunCateLine", { link = "LspSagaHoverBorder" })
  -- rename
  set(0, "LspSagaRenameBorder", { fg = c.blue })
  set(0, "LspSagaRenameMatch", { link = "Search" })
  -- diagnostic
  set(0, "LspSagaDiagnosticSource", { link = "Comment" })
  set(0, "LspSagaDiagnosticError", { link = "DiagnosticError" })
  set(0, "LspSagaDiagnosticWarn", { link = "DiagnosticWarn" })
  set(0, "LspSagaDiagnosticInfo", { link = "DiagnosticInfo" })
  set(0, "LspSagaDiagnosticHint", { link = "DiagnosticHint" })
  set(0, "LspSagaErrorTrunCateLine", { link = "DiagnosticError" })
  set(0, "LspSagaWarnTrunCateLine", { link = "DiagnosticWarn" })
  set(0, "LspSagaInfoTrunCateLine", { link = "DiagnosticInfo" })
  set(0, "LspSagaHintTrunCateLine", { link = "DiagnosticHint" })
  set(0, "LspSagaDiagnosticBorder", { fg = c.purple })
  set(0, "LspSagaDiagnosticHeader", { fg = c.green })
  set(0, "DiagnosticQuickFix", { fg = c.green, bold = true })
  set(0, "DiagnosticMap", { fg = c.pink })
  set(0, "DiagnosticLineCol", { fg = c.surface2 })
  set(0, "LspSagaDiagnosticTruncateLine", { link = "LspSagaDiagnosticBorder" })
  set(0, "ColInLineDiagnostic", { link = "Comment" })
  -- signture help
  set(0, "LspSagaSignatureHelpBorder", { fg = c.light_green })
  set(0, "LspSagaShTrunCateLine", { link = "LspSagaSignatureHelpBorder" })
  -- lightbulb
  set(0, "LspSagaLightBulb", { link = "DiagnosticSignHint" })
  -- shadow
  set(0, "SagaShadow", { fg = "black" })
  -- float
  set(0, "LspSagaBorderTitle", { link = "String" })
  -- Outline
  set(0, "LSOutlinePreviewBorder", { fg = c.green })
  set(0, "OutlineIndentEvn", { fg = c.pink })
  set(0, "OutlineIndentOdd", { fg = c.orange })
  set(0, "OutlineFoldPrefix", { fg = c.red })
  set(0, "OutlineDetail", { fg = c.surface2 })
  -- all floatwindow of lspsaga
  set(0, "LspFloatWinNormal", { link = "Normal" })
end

return M
