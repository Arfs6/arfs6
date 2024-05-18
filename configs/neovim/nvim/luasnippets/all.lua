local ls = require("luasnip")
print("Loaded all.lua!")
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
return {
  -- A snippet that expands the trigger "hi" into the string "Hello, world!".
  s(
    { trig = "hi" },
    { t("Hello, world!") }
  ),
}
