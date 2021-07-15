set nu rnu
set expandtab tabstop=4 softtabstop=4 shiftwidth=4
set nowrap 
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

function! g:SplitSetupForCPP()
    let l:fileName = expand('%:h:t')
    if(expand('%:e') == 'cpp' && winnr('$') <= 2)
        execute 'vs input.in | split output.in'
    else
        echo "PLESE OPEN CPP FILE"
    endif
endfunction

function! g:CompileAndRun()
    let l:fileName = expand('%:t:r')
    if(expand('%:e') == 'cpp')
        execute '!g++ '. l:fileName .'.cpp -o compiled/'. l:fileName .' 2>output.in && ./compiled/'. l:fileName .'<input.in>output.in'
    else
        echo "Sorry we can't compile the other file leaving cpp"
    endif
endfunction


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
