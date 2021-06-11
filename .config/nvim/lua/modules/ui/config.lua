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
    ["l"] = ":lua require'nvim-tree'.on_keypress('edit')<CR>",
    ["s"] = ":lua require'nvim-tree'.on_keypress('vsplit')<CR>",
    ["i"] = ":lua require'nvim-tree'.on_keypress('split')<CR>",
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

function config.lualine()
  require'lualine'.setup {
    options = {
      icons_enabled = true,
      theme = 'gruvbox',
      component_separators = {'|', '|'},
      section_separators = {'', ''},
      disabled_filetypes = {}
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

return config
