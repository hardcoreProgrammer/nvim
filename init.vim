set nu rnu
set expandtab tabstop=4 softtabstop=4 shiftwidth=4
set nowrap hidden
set nobackup noswapfile
set incsearch nohlsearch
set scrolloff=20
set guicursor=
set splitright splitbelow
set completeopt=menuone,noinsert,noselect

call plug#begin('~/.config/nvim/plugins/')
Plug 'vim-airline/vim-airline'
Plug 'sheerun/vim-polyglot'
Plug 'gruvbox-community/gruvbox'

Plug 'preservim/nerdcommenter'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/completion-nvim'

Plug 'tpope/vim-surround'
Plug 'preservim/nerdtree'
Plug 'ThePrimeagen/vim-be-good'
call plug#end()

let g:completion_matching_strategy_list = ['exact', 'substring', 'fuzzy']

lua << EOF
require('lspconfig').tsserver.setup{ on_attach=require'completion'.on_attach }
vim.o.completeopt = “menuone,noselect”require('compe').setup {
  enabled = true;
  autocomplete = true;
  debug = false;
  min_length = 1;
  preselect = 'enable';
  throttle_time = 80;
  source_timeout = 200;
  incomplete_delay = 400;
  max_abbr_width = 100;
  max_kind_width = 100;
  max_menu_width = 100;
  documentation = true;  source = {
    path = true;
    buffer = true;
    calc = true;
    nvim_lsp = true;
    nvim_lua = true;
    vsnip = true;
    ultisnips = true;
  };
}
EOF

colorscheme gruvbox

source ~/.config/nvim/custom/CPP.vim

" SHORTCUTS FOR THE VIM EDITOR
let mapleader=" "
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

nnoremap <C-e> :NERDTreeToggle<CR>
nnoremap <C-p> :GFiles<CR>

augroup startup
    autocmd! VimEnter * NERDTreeToggle | wincmd l 
augroup END

augroup CPP
    autocmd!
    autocmd! VimEnter *.cpp nnoremap <F8> :call g:CompileAndRun()<CR> | nnoremap <F4> :call g:SplitSetupForCPP()<CR>
augroup END
