local ls = require "luasnip" --{{{
local s = ls.s
local i = ls.i
local t = ls.t

local d = ls.dynamic_node
local c = ls.choice_node
local f = ls.function_node
local sn = ls.snippet_node

local fmt = require("luasnip.extras.fmt").fmt
local rep = require("luasnip.extras").rep --}}}

local snippets_config_factory = require "omareloui.config.snippets.utils"
local cs, snippets, autosnippets = snippets_config_factory("*.ts", "TypeScriptSnippets")

------------------------------ Start Refactoring ------------------------------

local function duplicate(import_name)
  return import_name[1][1]
end

local function duplicate_one()
  return f(duplicate, { 1 })
end

cs(
  "mongoosetypes",
  fmt(
    [[import type {{ Types }} from "mongoose";
import type {{
  MongooseDehydratedInstance,
  MongooseHydratedInstance,
  MongoosePojoInstance,
}} from "~/server/types";

type Dehydrated{}Fields<ID extends string | Types.ObjectId> = {{
  // eg.
  // user: ID;
}};

type {}Virtuals = {{}};

type {}PopulatedFields<
  O extends {{ isPojo: boolean }} = {{ isPojo: false }},
  P = O extends {{ isPojo: true }} ? true : false,
> = {{
  // eg.
  // user: P extends true ? UserPojo : UserInstance;
}};

export type Dehydrated{} = MongooseDehydratedInstance<
  Dehydrated{}Fields<Types.ObjectId>,
  {}Virtuals
>;

export type {}Instance = MongooseHydratedInstance<
  Dehydrated{}Fields<Types.ObjectId>,
  {}Virtuals
>;

export type {}Pojo = MongoosePojoInstance<
  Dehydrated{}Fields<string>,
  {}Virtuals
>;

export type Populated{}Instance = MongooseHydratedInstance<
  Dehydrated{}Fields<Types.ObjectId> & {}PopulatedFields,
  {}Virtuals
>;

export type Populated{}Pojo = MongoosePojoInstance<
  Omit<Dehydrated{}Fields<Types.ObjectId>, keyof {}PopulatedFields> &
    {}PopulatedFields<{{ isPojo: true }}>,
  {}Virtuals
>;]],

    {
      i(1, "InstanceName"),
      duplicate_one(),
      duplicate_one(),
      duplicate_one(),
      duplicate_one(),
      duplicate_one(),
      duplicate_one(),
      duplicate_one(),
      duplicate_one(),
      duplicate_one(),
      duplicate_one(),
      duplicate_one(),
      duplicate_one(),
      duplicate_one(),
      duplicate_one(),
      duplicate_one(),
      duplicate_one(),
      duplicate_one(),
      duplicate_one(),
      duplicate_one(),
      duplicate_one(),
    }
  )
)

cs(
  "mongoosemodel",
  fmt(
    [[import {{ Schema, model, type FlattenMaps }} from "mongoose";
import mongooseLeanVirtuals from "mongoose-lean-virtuals";
import mongooseLeanGetters from "mongoose-lean-getters";
import {{ accessibleRecordsPlugin, accessibleFieldsPlugin, AccessibleModel }} from "@casl/mongoose";

import type {{ FinalType, ObjectId, ReplaceValueType, Timestamp }} from "~/types";


type I{} = {{}};

type I{}Virtuals = {{}};

type I{}Methods = {{}};

const {}Schema = new Schema<I{}>(
  {{}},
  {{
    timestamps: true,
    versionKey: false,
    toJSON: {{
      virtuals: true,
      getters: true,
      transform(_doc, ret) {{
        delete ret.id;
        delete ret.__t;
      }},
    }},
    toObject: {{
      virtuals: true,
      getters: true,
      transform(_doc, ret) {{
        delete ret.id;
        delete ret.__t;
      }},
    }},
  }},
);

[mongooseLeanVirtuals, mongooseLeanGetters, accessibleRecordsPlugin, accessibleFieldsPlugin].forEach(p =>
  {}Schema.plugin(p),
);

export const {} = model<I{}, AccessibleModel<I{}, unknown, I{}Methods, I{}Virtuals>>("{}", {}Schema);

export type {}Doc = FinalType<ReturnType<(typeof {})["hydrate"]> & Timestamp>;
export type {}Lean = FlattenMaps<{{ _id: ObjectId }} & I{} & I{}Virtuals & Timestamp>;
export type {}Pojo = ReplaceValueType<{}Lean, ObjectId, string>;
export type {}PopulatedFields = {{}};

declare module "@casl/mongoose" {{
  interface RecordTypes {{
    {}: true;
  }}
}}
]],
    {
      i(1, "Model"),
      duplicate_one(),
      duplicate_one(),
      duplicate_one(),
      duplicate_one(),
      duplicate_one(),
      duplicate_one(),
      duplicate_one(),
      duplicate_one(),
      duplicate_one(),
      duplicate_one(),
      duplicate_one(),
      duplicate_one(),
      duplicate_one(),
      duplicate_one(),
      duplicate_one(),
      duplicate_one(),
      duplicate_one(),
      duplicate_one(),
      duplicate_one(),
      duplicate_one(),
      duplicate_one(),
    }
  )
)

------------------------------- End Refactoring -------------------------------

return snippets, autosnippets
