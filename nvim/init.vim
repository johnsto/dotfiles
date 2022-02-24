""" Load plugins
call plug#begin()
" Multi language support
Plug 'sheerun/vim-polyglot'
Plug 'neovim/nvim-lspconfig'
Plug 'mfussenegger/nvim-lint'
Plug 'dense-analysis/ale'

" Completion
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/vim-vsnip'
Plug 'rafamadriz/friendly-snippets'

" File finders
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope-fzf-native.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'kshenoy/vim-signature'
Plug 'burntsushi/ripgrep'
Plug 'scrooloose/nerdtree'
" Appearance
Plug 'mhartington/oceanic-next'
Plug 'itchyny/lightline.vim'
Plug 'maximbaz/lightline-ale'
Plug 'ntpeters/vim-better-whitespace'
" Tags
Plug 'majutsushi/tagbar'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-treesitter/completion-treesitter'
" Git
Plug 'lewis6991/gitsigns.nvim'
Plug 'tpope/vim-fugitive'
" Go
Plug 'fatih/vim-go'
" .NET
Plug 'OmniSharp/omnisharp-vim'
" JavaScript
Plug 'retorillo/istanbul.vim' " Coverage
" Erlang
Plug 'vim-erlang/vim-erlang-runtime'
call plug#end()

""" Enable true colour support
if (has("nvim"))
	let $NVIM_TUI_ENABLE_TRUE_COLOR=1
endif
if (has("termguicolors"))
	set termguicolors
endif

""" Force 256 colour theme.
set t_Co=256

""" Set colour scheme
colorscheme OceanicNext

let mapleader = ","

""" Set better defaults
set ruler					" Show ruler
set incsearch				" Show search matches as term is typed in
set ignorecase
set number
set hlsearch				" Highlight matching terms
set showmatch				" Show matching bracket when inserted
set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()
set foldlevel=99

""" More useful indentation
set smartindent				" Smartly indent new lines
set tabstop=4
set shiftwidth=4

set completeopt=menu,menuone,noselect

set hidden					" Don't mark buffers as abandoned if not visible
set nocompatible			" Don't try to be like vim
set visualbell				" Flash instead of beep
set colorcolumn=120			" Enable column marker
set laststatus=2

set spell					" Enable spelling

syntax on 					" Enable syntax highlighting

""" Tab navigation shortcuts
map th :tabfirst<CR>
map tj :tabnext<CR>
map tk :tabprev<CR>
map tl :tablast<CR>
map tt :tabedit<Space>
map tn :tabnext<Space>
map tm :tabm<Space>

""" Allow navigation between windows with Alt+Arrows
nmap <silent> <A-Up> :wincmd k<CR>
nmap <silent> <A-Down> :wincmd j<CR>
nmap <silent> <A-Left> :wincmd h<CR>
nmap <silent> <A-Right> :wincmd l<CR>

""" Bind file listers
nmap <Tab> <cmd>Telescope buffers<CR>
nmap <C-p> <cmd>Telescope find_files<CR>
nmap <C-g> <cmd>Telescope live_grep<cr>
nmap <C-e> <cmd>Telescope grep_string<cr>
nmap go <cmd>Telescope file_browser<cr>
nmap gr <cmd>Telescope lsp_references<cr>
nmap gd <cmd>Telescope lsp_definitions<cr>
nmap gf <cmd>Telescope lsp_document_symbols<cr>

""" NERD tweaks
" If another buffer tries to replace NERDTree, put it in the other window, and bring back NERDTree.
autocmd BufEnter * if bufname('#') =~ 'NERD_tree_\d\+' && bufname('%') !~ 'NERD_tree_\d\+' && winnr('$') > 1 |
    \ let buf=bufnr() | buffer# | execute "normal! \<C-W>w" | execute 'buffer'.buf | endif

""" Lightline options
set noshowmode " Don't show INSERT mode in command window
let g:lightline = {
	\ 'tabline_separator': {'left': "", 'right': ""},
	\ 'tabline_subseparator': {'left': "", 'right': ""},
	\ 'active': {                                                                                               
        	\ 'left': [ ['mode', 'paste'], ['readonly', 'filename', 'modified', 'method'] ],                    
        	\ 'right': [ [ 'linter_checking', 'linter_errors', 'linter_warnings', 'linter_infos', 'linter_ok' ],
		\            [ 'lineinfo' ],                                                                           
        	\            [ 'percent' ],                                                                         
        	\            [ 'fileformat', 'fileencoding', 'filetype'] ]                                          
	\ },                                                                                                        
	\ 'component_function': {'filename': 'LightlineFilename', 'method': 'NearestMethodOrFunction'},
    \ }
function! LightlineFilename()
  return expand('%:p')
endfunction

let g:lightline.component_expand = {
      \  'linter_checking': 'lightline#ale#checking',
      \  'linter_infos': 'lightline#ale#infos',
      \  'linter_warnings': 'lightline#ale#warnings',
      \  'linter_errors': 'lightline#ale#errors',
      \  'linter_ok': 'lightline#ale#ok',
      \ }
let g:lightline.component_type = {
      \     'linter_checking': 'right',
      \     'linter_infos': 'right',
      \     'linter_warnings': 'warning',
      \     'linter_errors': 'error',
      \     'linter_ok': 'right',
      \ }


""" COC options
set hidden
set nobackup					" Don't write backups
set nowritebackup
set cmdheight=2					" Increase command window height
set updatetime=300				" Wait prior to updating swapfile
set shortmess+=c
set signcolumn=yes

""" Completion
lua <<EOF
  -- Setup nvim-cmp.
  local cmp = require'cmp'

  cmp.setup({
    snippet = {
      expand = function(args)
        vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
      end,
    },
    mapping = {
      ['<C-d>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
      ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
      ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
      ['<C-y>'] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
      ['<C-e>'] = cmp.mapping({
        i = cmp.mapping.abort(),
        c = cmp.mapping.close(),
      }),
      ['<CR>'] = cmp.mapping.confirm({ select = false }),
    },
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'vsnip' }, -- For vsnip users.
    }, {
      { name = 'buffer' },
    })
  })

  -- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline('/', {
    sources = {
      { name = 'buffer' }
    }
  })

  -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline(':', {
    sources = cmp.config.sources({
      { name = 'path' }
    }, {
      { name = 'cmdline' }
    })
  })

  -- Setup lspconfig.
  local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
  require('lspconfig')['gopls'].setup {
    capabilities = capabilities
  }
EOF

""" Coverage options
let g:coverage_json_report_path = 'coverage/coverage-final.json'
let g:coverage_sign_covered = '⦿'

""" Go
autocmd BufNewFile,BufRead *.go setlocal noexpandtab tabstop=4 shiftwidth=4

let g:go_def_reuse_buffer = 0
let g:go_fmt_fail_silently = 1
let g:go_highlight_build_constraints = 1
let g:go_metalinter_autosave = 0
let g:go_jump_to_error = 0
let g:go_gopls_gofumpt = 1

autocmd FileType go nmap <leader>gt <Plug>(go-test)
autocmd FileType go nmap <leader>gT <Plug>(go-test-func)
autocmd FileType go nmap <leader>gl <Plug>(go-lint)
autocmd FileType go nmap <leader>gR <Plug>(go-rename)
autocmd FileType go nmap <Leader>gc <Plug>(go-coverage)
autocmd FileType go nmap <Leader>gi <Plug>(go-imports)
autocmd FileType go nmap <Leader>gC <Plug>(go-coverage-clear)
autocmd FileType go nmap <Leader>gf <Plug>(go-format)
autocmd FileType go nmap <Leader>p <Plug>(go-def-pop)
autocmd Filetype go command! -bang AT call go#alternate#Switch(<bang>0, 'tabe')
au BufRead,BufNewFile *.gohtml set filetype=gohtmltmplrage-toggle)<Paste>

""" .YAML
autocmd BufNewFile,BufRead *.yaml setlocal tabstop=2 softtabstop=0 expandtab shiftwidth=2 smarttab filetype=yaml

au BufWritePost <buffer> lua require('lint').try_lint()

lua require('gitsigns').setup()
