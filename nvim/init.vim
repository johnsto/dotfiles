let mapleader = ","

set ruler
set incsearch
set number
set hlsearch
set showmatch
set smartindent
set tabstop=4
set shiftwidth=4

set completeopt=menu

" Load plugins
call plug#begin()
" Fuzzy file filder
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
" Tmux integration
Plug 'benmills/vimux'
Plug 'benmills/vimux-golang'
Plug 'christoomey/vim-tmux-navigator'
" Themes
Plug 'mhartington/oceanic-next'
Plug 'rakr/vim-one'
Plug 'jnurmine/Zenburn'
" Autocomplete
Plug 'ycm-core/YouCompleteMe'
" Pretty file icons
Plug 'ryanoasis/vim-devicons'
" Go plugins
Plug 'fatih/vim-go'
" .NET plugins
Plug 'OmniSharp/omnisharp-vim'
" JavaScript plugins
Plug 'HerringtonDarkholme/yats.vim'
Plug 'mhartington/nvim-typescript', {'do': './install.sh'}
"
Plug 'majutsushi/tagbar'
" Gid
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'

call plug#end()

" Enable true colour support
if (has("nvim"))
	let $NVIM_TUI_ENABLE_TRUE_COLOR=1
endif
if (has("termguicolors"))
	set termguicolors
endif

set hidden					" Don't mark buffers as abandoned if not visible
set nocompatible			" Don't try to be like vim
set visualbell				" Flash instead of beep
set colorcolumn=120			" Enable column marker
syntax on 					" Enable syntax highlighting

" Filetype specific tweaks

" TypeScript
autocmd FileType ts nmap <Leader>g :TSDef<CR>
"

" Go
autocmd BufNewFile,BufRead *.go setlocal noexpandtab tabstop=4 shiftwidth=4 

let g:go_def_reuse_buffer = 0
let g:go_fmt_fail_silently = 1
let g:go_highlight_build_constraints = 1
let g:go_metalinter_autosave = 1
let g:go_jump_to_error = 0
"let g:go_list_type = "quickfix"
"
function! s:build_go_files()
  let l:file = expand('%')
  if l:file =~# '^\f\+_test\.go$'
    call go#test#Test(0, 1)
  elseif l:file =~# '^\f\+\.go$'
    call go#cmd#Build(0)
  endif
endfunction

autocmd FileType go nmap <leader>b <Plug>(go-build)
autocmd FileType go nmap <leader>t <Plug>(go-test)
autocmd FileType go nmap <leader>T <Plug>(go-test-func)
autocmd FileType go nmap <leader>l <Plug>(go-lint)
autocmd FileType go nmap <leader>r <Plug>(go-run)
autocmd FileType go nmap <leader>R <Plug>(go-rename)
autocmd FileType go nmap <Leader>c <Plug>(go-coverage)
autocmd FileType go nmap <Leader>i <Plug>(go-imports)
autocmd FileType go nmap <Leader>C <Plug>(go-coverage-clear)
autocmd FileType go nmap gd <Plug>(go-def-tab)
autocmd FileType go nmap <Leader>p <Plug>(go-def-pop)
autocmd Filetype go command! -bang AT call go#alternate#Switch(<bang>0, 'tabe')
au BufRead,BufNewFile *.gohtml set filetype=gohtmltmplrage-toggle)<Paste>

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

nmap <F8> :TagbarToggle<CR>

" Open NERDTree instead of Ctrlp
nmap <C-p> :FZF<CR>
"map <Leader>t :NERDTreeToggle<CR>

" Enable deoplete on startup
let g:deoplete#enable_at_startup = 1
