return {
  "L3MON4D3/LuaSnip",
  build = "make install_jsregexp",
  config = function()
    local ls = require("luasnip")
    local s = ls.snippet
    local t = ls.text_node
    local i = ls.insert_node
    
    -- Load extras (Important for rep and fmt)
    local extras = require("luasnip.extras")
    local rep = extras.rep
    local fmt = require("luasnip.extras.fmt").fmt

    -- Enable autosnippets
    ls.config.set_config({
      enable_autosnippets = true,
    })

    -- Add snippets for LaTeX (tex)
    ls.add_snippets("tex", {
      
      -- 1. INLINE MATH ('mk') -> $...$
      s({trig = "mk", snippetType = "autosnippet"}, {
        t("$"), i(1), t("$"), i(0)
      }),

      -- 2. DISPLAY MATH ('dm') -> \[...\]
      s({trig = "dm", snippetType = "autosnippet"}, {
        t({"\\[", "\t"}), i(1), t({"", "\\]"}), i(0)
      }),

      -- 3. ENVIRONMENT ('beg') -> \begin{...} ... \end{...}
      -- Uses <> delimiters so it doesn't break LaTeX braces
      s({trig = "beg", snippetType = "autosnippet"},
        fmt(
          [[
          \begin{<>}
              <>
          \end{<>}
          ]],
          { i(1), i(0), rep(1) },
          { delimiters = "<>" }
        )
      ),
    })
    
    -- Keymaps for jumping (Tab / Shift-Tab)
    vim.keymap.set({"i", "s"}, "<Tab>", function()
      if ls.expand_or_jumpable() then
        ls.expand_or_jump()
      else
        -- If not in a snippet, just act like a normal Tab key
        vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Tab>", true, false, true), "n", false)
      end
    end, { silent = true })

    vim.keymap.set({"i", "s"}, "<S-Tab>", function()
      if ls.jumpable(-1) then
        ls.jump(-1)
      else
        vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<S-Tab>", true, false, true), "n", false)
      end
    end, { silent = true })
  end,
}
