-- Setup nvim-cmp.
local cmp = require "cmp"
local lspkind = require "lspkind"

local has_words_before = function()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local luasnip = require "luasnip"

cmp.setup(
  {
    snippet = {
      -- REQUIRED - you must specify a snippet engine
      expand = function(args)
        -- vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
        luasnip.lsp_expand(args.body) -- For `luasnip` users.
        -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
        -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
      end
    },
    window = {},
    formatting = {
      format = lspkind.cmp_format(
        {
          -- adds nice pictograms for lsp completion sources
          with_text = false, -- do not show text alongside icons
          maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
          -- The function below will be called before any actual modifications from lspkind
          -- so that you can provide more controls on popup customization. (See [#30](https://github.com/onsails/lspkind-nvim/pull/30))
          before = function(entry, vim_item)
            return vim_item
          end
        }
      )
    },
    mapping = cmp.mapping.preset.insert(
      {
        ["<Tab>"] = cmp.mapping(
          function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            elseif has_words_before() then
              cmp.complete()
            else
              fallback()
            end
          end,
          {"i", "s"}
        ),
        ["<S-Tab>"] = cmp.mapping(
          function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end,
          {"i", "s"}
        ),
        ["<C-b>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-e>"] = cmp.mapping.abort(),
        ["<CR>"] = cmp.mapping.confirm({select = true}) -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
      }
    ),
    sources = cmp.config.sources(
      {
        {name = "nvim_lsp"},
        {name = "luasnip"},
        {name = "latex-symbols"},
        {name = "buffer"},
        {name = "spell"}
      },
      {}
    )
  }
)

-- Set configuration for specific filetype.
cmp.setup.filetype(
  "gitcommit",
  {
    sources = cmp.config.sources(
      {
        {name = "cmp_git"} -- You can specify the `cmp_git` source if you were installed it.
      },
      {
        {name = "buffer"}
      }
    )
  }
)

-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(
  "/",
  {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
      {name = "buffer"}
    }
  }
)

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(
  ":",
  {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources(
      {
        {name = "path"}
      },
      {
        {name = "cmdline"}
      }
    )
  }
)

-- Setup lspconfig.
local capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities())
-- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
require("lspconfig").clangd.setup {
  capabilities = capabilities
}
