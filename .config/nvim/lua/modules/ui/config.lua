local config = {}

function config.nvim_tree()
  -- On Ready Event for Lazy Loading work
  require("nvim-tree.events").on_nvim_tree_ready(function()
    vim.cmd("NvimTreeRefresh")
  end
  )
  vim.g.nvim_tree_follow = 1
  vim.g.nvim_tree_hide_dotfiles = 1
  vim.g.nvim_tree_indent_markers = 1
  vim.g.nvim_tree_bindings = {
    {key = {'l'}, cb = "<cmd>lua require'nvim-tree'.on_keypress('edit')<CR>"};
    {key = {'s'}, cb = "<cmd>lua require'nvim-tree'.on_keypress('vsplit')<CR>"};
    {key = {'i'}, cb = "<cmd>lua require'nvim-tree'.on_keypress('split')<CR>"};
  }
  vim.g.nvim_tree_icons = {
    default =  '',
    symlink =  '',
    git = {
      unstaged = "✚",
      staged =  "✚",
      unmerged =  "≠",
      renamed =  "≫",
      untracked = "★",
    },
  }
end

function config.nvim_bufferline()
  require('bufferline').setup{}
end

function config.gruvbox()
  vim.g.gruvbox_invert_selection = 0
  vim.g.gruvbox_italic = 1
  vim.cmd('autocmd vimenter * ++nested colorscheme gruvbox')
end

function config.material_nvim()
  vim.g.material_style = "deep ocean"
  vim.g.material_italic_comments = true
  vim.g.material_italic_keywords = true
  vim.g.material_italic_variables = true
  vim.g.material_borders = true

  vim.g.material_custom_colors = {
    selection = '#4f5470'
  }

  require('material').set()
end

function config.lualine()
  require'lualine'.setup {
    options = {
      icons_enabled = true,
      theme = 'vscode',
      component_separators = {'|', '|'},
      section_separators = {'', ''},
      disabled_filetypes = {'NvimTree'}
    },
    sections = {
      lualine_a = {'mode'},
      lualine_b = {'branch'},
      lualine_c = {
        'filename',
        {
          'diagnostics',
          sources = {'nvim_lsp'},
        }
      },
      lualine_x = {},
      lualine_y = {
        {'o:encoding', upper = true},
        {'fileformat', icons_enabled = false, upper = true},
        {'filetype'},
      },
      lualine_z = {'location'}
    },
    inactive_sections = {
      lualine_a = {},
      lualine_b = {},
      lualine_c = {'filename'},
      lualine_x = {'location'},
      lualine_y = {},
      lualine_z = {}
    },
    tabline = {},
    extensions = {}
  }
end

function config.indent_blakline()
  vim.cmd [[nnoremap <leader><leader>i <cmd>IndentBlanklineToggle<cr>]]
  vim.g.indent_blankline_char = "│"
  vim.g.indent_blankline_show_first_indent_level = true
  vim.g.indent_blankline_filetype_exclude = {
    "startify",
    "dashboard",
    "dotooagenda",
    "log",
    "fugitive",
    "gitcommit",
    "packer",
    "vimwiki",
    "markdown",
    "txt",
    "vista",
    "help",
    "todoist",
    "NvimTree",
    "peekaboo",
    "git",
    "TelescopePrompt",
    "undotree",
    "flutterToolsOutline",
    "" -- for all buffers without a file type
  }
  vim.g.indent_blankline_buftype_exclude = {"terminal", "nofile"}
  vim.g.indent_blankline_show_trailing_blankline_indent = false
end

function config.gitsigns()
  if not packer_plugins['plenary.nvim'].loaded then
    vim.cmd [[packadd plenary.nvim]]
  end

  require('gitsigns').setup {
    signs = {
      delete = {text = '│'},
    },
    keymaps = {
      ['n ]c'] = {expr = true, "&diff ? ']c' : '<cmd>lua require\"gitsigns\".next_hunk()<CR>'"},
      ['n [c'] = {expr = true, "&diff ? '[c' : '<cmd>lua require\"gitsigns\".prev_hunk()<CR>'"},

      ['n <leader><leader>hs'] = '<cmd>lua require"gitsigns".stage_hunk()<CR>',
      ['v <leader>hs'] = '<cmd>lua require"gitsigns".stage_hunk({vim.fn.line("."), vim.fn.line("v")})<CR>',
      ['n <leader><leader>hu'] = '<cmd>lua require"gitsigns".undo_stage_hunk()<CR>',
      ['n <leader><leader>hr'] = '<cmd>lua require"gitsigns".reset_hunk()<CR>',
      ['v <leader>hr'] = '<cmd>lua require"gitsigns".reset_hunk({vim.fn.line("."), vim.fn.line("v")})<CR>',
      ['n <leader><leader>hR'] = '<cmd>lua require"gitsigns".reset_buffer()<CR>',
      ['n <leader><leader>hp'] = '<cmd>lua require"gitsigns".preview_hunk()<CR>',
      ['n <leader><leader>hb'] = '<cmd>lua require"gitsigns".blame_line(true)<CR>',
      ['n <leader><leader>hS'] = '<cmd>lua require"gitsigns".stage_buffer()<CR>',
      ['n <leader><leader>hU'] = '<cmd>lua require"gitsigns".reset_buffer_index()<CR>',

      ['o ih'] = ':<C-U>lua require"gitsigns".select_hunk()<CR>',
      ['x ih'] = ':<C-U>lua require"gitsigns".select_hunk()<CR>'
    }
  }
end

return config
