set ruler
set incsearch
set number
set hlsearch
set showmatch
set smartindent

" Load plugins
call plug#begin()
Plug 'ctrlpvim/ctrlp.vim'
" Tmux integration
Plug 'benmills/vimux'
Plug 'benmills/vimux-golang'
Plug 'christoomey/vim-tmux-navigator'
" Themes
Plug 'mhartington/oceanic-next'
Plug 'rakr/vim-one'
Plug 'jnurmine/Zenburn'
" Go plugins
Plug 'fatih/vim-go'
Plug 'nsf/gocode', { 'rtp': 'vim', 'do': '~/.vim/plugged/gocode/vim/symlink.sh' }
Plug 'Shougo/deoplete.nvim'
Plug 'zchee/deoplete-go'
Plug 'garyburd/go-explorer'
Plug 'jodosha/vim-godebug'
call plug#end()

" Enable true colour support
if (has("nvim"))
	let $NVIM_TUI_ENABLE_TRUE_COLOR=1
endif
if (has("termguicolors"))
	set termguicolors
endif

" Enable syntax highlighting
syntax on

" Filetype specific tweaks
autocmd FileType go setlocal tabstop=4 shiftwidth=4

" Force 256 colour theme.
set t_Co=256

" Set colour scheme
colorscheme OceanicNext

" Tab navigation shortcuts
map th :tabfirst<CR>
map tj :tabnext<CR>
map tk :tabprev<CR>
map tl :tablast<CR>
map tt :tabedit<Space>
map tn :tabnext<Space>
map tm :tabm<Space>

nmap <silent> <A-Up> :wincmd k<CR>
nmap <silent> <A-Down> :wincmd j<CR>
nmap <silent> <A-Left> :wincmd h<CR>
nmap <silent> <A-Right> :wincmd l<CR>

" Enable deoplete on startup
let g:deoplete#enable_at_startup = 1
