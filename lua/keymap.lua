local map = function(key)
  -- get the extra options
  local opts = {}
  for i, v in pairs(key) do
    if type(i) == "string" then
      opts[i] = v
    end
  end

  -- basic support for buffer-scoped keybindings
  local buffer = opts.buffer
  opts.buffer = nil

  if buffer then
    vim.api.nvim_buf_set_keymap(0, key[1], key[2], key[3], opts)
  else
    vim.api.nvim_set_keymap(key[1], key[2], key[3], opts)
  end
end

-- Go to first and last characters in line
map {"", "<space>l", "$"}
map {"", "<space>h", "^"}

-- Prevent accidentally going into Ex mode
-- map Q qq
map {"", "Q", "qq"}

-- Faster exiting from insert mode
map {"i", "jj", "<esc>"}

-- Stop highlighting search results
map {"n", "<A-h>", ":nohlsearch<cr>", silent = true}

map {"", "<A-e>", ":w<cr>", silent = true}

-- "in document" (from first line to last; cursor at top--ie, gg)
map {"x", "id", ":<c-u>normal! G$Vgg0<cr>", noremap = true, silent = true}
map {"o", "id", ":<c-u>normal! GVgg<cr>", noremap = true, silent = true}

-- Need that because of vim-cutlass
map {"n", "m", "d", noremap = true}
map {"x", "m", "d", noremap = true}
map {"n", "mm", "dd", noremap = true}
map {"n", "M", "D", noremap = true}

map {"n", "<space>d", ":Bdelete<cr>", noremap = true, silent = true}
map {"n", "<space>b", ":bprevious<cr>", noremap = true, silent = true}
map {"n", "<space>n", ":bnext<cr>", noremap = true, silent = true}

-- Easymotion bindings
map {"n", "<Leader>es", "<Plug>(easymotion-s2)"}
map {"n", "<Leader>et", "<Plug>(easymotion-t2)"}
map {"", "<Leader>j", "<Plug>(easymotion-j)"}
map {"", "<Leader>k", "<Plug>(easymotion-k)"}

-- Vim-subversive bindings
map {"n", "ss", "<Plug>(SubversiveSubstituteLine)"}
map {"n", "S", "<Plug>(SubversiveSubstituteToEndOfLine)"}

map {"n", "<leader>s", "<Plug>(SubversiveSubstituteRange)"}
map {"x", "<leader>s", "<Plug>(SubversiveSubstituteRange)"}
map {"n", "<leader>ss", "<Plug>(SubversiveSubstituteWordRange)"}

-- Incsearch + Easymotion
map {"", "<space>zs", "<Plug>(incsearch-easymotion-/)"}
map {"", "<space>zS", "<Plug>(incsearch-easymotion-?)"}
map {"", "<space>zg", "<Plug>(incsearch-easymotion-stay)"}

-- Dashboard Nvim use FZF
vim.g.dashboard_default_executive = "fzf"
vim.g.floaterm_keymap_toggle = "<Leader>tt"

map {"", "<leader>tp", ":FloatermNew python<cr>", noremap = true, silent = true}
map {"", "<leader>tP", ":'<,'>FloatermNew python<cr>", noremap = true, silent = true}

map {"n", "<leader>n", ":CHADopen<cr>", noremap = true, silent = true}

map {"", "<space>ca", ":CodeActionMenu<cr>", silent = true}

map {"n", "<leader>ff", "<cmd>Telescope find_files<cr>", noremap = true}
map {"n", "<leader>fg", "<cmd>Telescope live_grep<cr>", noremap = true}
map {"n", "<leader>fb", "<cmd>Telescope buffers<cr>", noremap = true}
map {"n", "<leader>fh", "<cmd>Telescope help_tags<cr>", noremap = true}
map {"n", "<leader>fs", "<cmd>Telescope lsp_document_symbols<cr>", noremap = true}
map {"n", "<leader>fd", "<cmd>Telescope diagnostics<cr>", noremap = true}
map {"n", "<leader>ft", "<cmd>Telescope treesitter<cr>", noremap = true}

map {"n", "<A-j>", "10j", {}}
map {"n", "<A-k>", "10k", {}}

map {"n", "<space>f", ":Format<cr>", silent = true}

map {"n", "gm", "%"}

-- Clear quickfix list
map {"n", "<leader>l", [[<cmd>call setqflist([])<cr>]], silent = true, noremap = true}

-- Split resize
map { "n", "<leader>-v", "<cmd>vertical resize -10<cr>", noremap = true }
map { "n", "<leader>+v", "<cmd>vertical resize +10<cr>", noremap = true }
map { "n", "<leader>-h", "<cmd>vertical resize -10<cr>", noremap = true }
map { "n", "<leader>+h", "<cmd>vertical resize +10<cr>", noremap = true }

-- Write to read only files
map { "c", "w!!", "execute 'silent! write !sude tee % >/dev/null' <bar> edit!", noremap = true }
