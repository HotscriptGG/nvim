" Sane tab settings
set tabstop=4 softtabstop=4
set shiftwidth=4
set expandtab
set smartindent

" Search settings
" No highlighting when searching - TODO: find better
set nohlsearch
" Search in file after every character
set incsearch

" Sane swap files behaviour
set noswapfile
set nobackup
set undodir=~/.nvim/undodir
set undofile

" Source vimrc file if present in project directory.
set exrc
" Relative line numbers
set relativenumber
" Show current line true number
set nu
" Don't close buffers on opening other files - TODO: find better, use tabs?
set hidden
" No unix bells
set noerrorbells
" Keep som distance at the top and bottom when scorolling
set scrolloff=8
" Use nice colors
set termguicolors
" Add extra column on the left. Useful with plugins, etc.
set signcolumn=yes
" Show margins
set colorcolumn=80,120

" Plugins
call plug#begin('~/.vim/plugged')
" Fuzzy finder
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" Nice status bar
Plug 'vim-airline/vim-airline'
Plug 'nvim-lua/lsp-status.nvim'

" Tracking changes
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-treesitter/playground'

" Change to root directory when opening file
Plug 'airblade/vim-rooter'

" Debuggers
Plug 'puremourning/vimspector'
Plug 'szw/vim-maximizer'

" Git
Plug 'tpope/vim-fugitive'

" Code completion and language specific development tools
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/completion-nvim'
Plug 'tjdevries/nlua.nvim'
Plug 'tjdevries/lsp_extensions.nvim'
Plug 'fatih/vim-go'

" Parentheses and brackets autocomplete
Plug 'jiangmiao/auto-pairs'

" Color themes
" Favourite theme
Plug 'dracula/vim', { 'as': 'dracula' }
" Backup theme
Plug 'gruvbox-community/gruvbox'
call plug#end()

" Language configs
" -- Go
lua require'lspconfig'.gopls.setup{}
" -- Javascript, Typescript, Node, React
lua require'lspconfig'.tsserver.setup{}
" -- HTML
lua require'lspconfig'.html.setup{}
" -- PHP
lua require'lspconfig'.intelephense.setup{}
" -- Shell
lua require'lspconfig'.bashls.setup{}
" -- Rust
lua require'lspconfig'.rls.setup{}
lua require'lspconfig'.rust_analyzer.setup{}
" -- Python
" -- SQL
lua require'lspconfig'.sqlls.setup { cmd = "sql-language-server", "up", "--method", "stdio" }
" -- Dart
lua require'lspconfig'.dartls.setup {}
" -- C, Cpp
" Treesitter
lua require'nvim-treesitter.configs'.setup { highlight = { enable = true } }
" Use autocompletion in every buffer
autocmd BufEnter * lua require'completion'.on_attach()
" Use <Tab> and <S-Tab> to navigate through popup menu
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
" Set completeopt to have a better completion experience
set completeopt=menuone,noinsert,noselect

" Avoid showing message extra message when using completion
set shortmess+=c

" Set colorscheme
colorscheme dracula

" Remaps and keybindings
let mapleader = " "
nnoremap <leader>p <cmd>Telescope find_files<CR>
" Ctrl+s to save
noremap <silent> <C-S>          :update<CR>
vnoremap <silent> <C-S>         <C-C>:update<CR>
inoremap <silent> <C-S>         <C-O>:update<CR>

" Functions
fun! TrimWhitespace()
    let l:save = winsaveview()
    keeppatterns %s/\s\+$//e
    call winrestview(l:save)
endfun

augroup KUMA_AS
    autocmd!
    autocmd BufWritePre * :call TrimWhitespace()
augroup END

augroup highlight_yank
    autocmd!
    autocmd TextYankPost * silent! lua require'vim.highlight'.on_yank({timeout = 150})
augroup END

