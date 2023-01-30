
" diable unused remote-plugins provider
let g:loaded_python_provider = 0 " disable python2 provider
let g:loaded_python3_provider = 0
let g:loaded_ruby_provider = 0
let g:loaded_perl_provider = 0
let g:loaded_node_provider = 0

"------------------ global options -------------------------
" Use the directory of the related buffer
set browsedir=buffer

set fileencoding=utf-8
set fileencodings=utf-8,gb18030,gbk,gb2312,ucs-bom,cp936,latin1

set number
" set relativenumber

" no swapfile
set nobackup
set noswapfile
set nowritebackup

set scrolloff=5

" default tab size
set tabstop=2
set expandtab
set cindent shiftwidth=2
set autoindent shiftwidth=2
set smartindent
"enable mouse
set mouse=a
" default split position
set splitright
set splitbelow

set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.png,*.jpg,*.jpeg,*.gif,*.beam
set wildignore+=*/node_modules/*,*/vendor/*
set wildoptions=pum

" set popup list count
set pumheight=12
set pumblend=10

set lazyredraw
set jumpoptions=stack
" Smaller updatetime for CursorHold & CursorHoldI
set updatetime=400
" don't give |ins-completion-menu| messages.
set shortmess+=c
" always show signcolumns
set signcolumn=auto:1
" disable syntax highlight for long lines
set synmaxcol=1000

set cursorline
set termguicolors

set completeopt=menu,menuone,noselect
" colorscheme onedark
" turn on linematch for diff
set diffopt+=linematch:60

" highlight on yank
au TextYankPost * silent! lua vim.highlight.on_yank()

"---------------  key maps ---------------------
" map leader to space
let mapleader = "\<Space>"
nnoremap <silent> <leader>, :nohlsearch<CR>

" map ; to :
nnoremap ; :
" map Ctrl c to copy for terminal
vnoremap <C-c> "+y
nnoremap <C-c> "+yy

" Easy window navigation
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Reselect visual block after indent/outdent
vnoremap < <gv
vnoremap > >gv

nnoremap H ^
nnoremap L $

" readline style for insert mode. copy from tpope/vim-rsi
inoremap <C-A> <C-O>^
cnoremap <C-A> <Home>
inoremap <expr> <C-B> getline('.')=~'^\s*$'&&col('.')>strlen(getline('.'))?"0\<Lt>C-D>\<Lt>Esc>kJs":"\<Lt>Left>"
cnoremap <C-B> <Left>
inoremap <expr> <C-D> col('.')>strlen(getline('.'))?"\<Lt>C-D>":"\<Lt>Del>"
cnoremap <expr> <C-D> getcmdpos()>strlen(getcmdline())?"\<Lt>C-D>":"\<Lt>Del>"
inoremap <expr> <C-E> col('.')>strlen(getline('.'))<bar><bar>pumvisible()?"\<Lt>C-E>":"\<Lt>End>"
inoremap <expr> <C-F> col('.')>strlen(getline('.'))?"\<Lt>C-F>":"\<Lt>Right>"
cnoremap <expr> <C-F> getcmdpos()>strlen(getcmdline())?&cedit:"\<Lt>Right>"

" mac options key to alt
if has("mac")
  nmap ˙ <M-h>
  nmap ∆ <M-j>
  nmap ˚ <M-k>
  nmap ¬ <M-k>
endif

" map contrl-s to save
inoremap <C-S> <C-C>:w<CR>
inoremap <D-s> <esc>:w<cr>
noremap :W :w<CR>
"imap jj <ESC>
nnoremap ^T :tabnew .<CR>
nnoremap <D-j> :tabprevious<CR>
nnoremap <D-k> :tabnext<CR>
nnoremap <D-S-{> :tabprevious<CR>
nnoremap <D-S-}> :tabnext<CR>

" --- markdown -------------
let g:vim_markdown_folding_disabled=1
let g:vim_markdown_fenced_languages = ['bash=sh', 'ruby', 'javascript', 'lua']
let g:vim_markdown_conceal = 0

"--------- AnyJump --------{{{
let g:any_jump_grouping_enabled = 1
nnoremap <leader>j :AnyJump<CR>
"}}}
"
"--------- copilot --------{{{
" imap <silent><script><expr> <C-l> copilot#Accept("\<CR>")
" let g:copilot_no_tab_map = v:true

"------ golang is special ----------
au FileType go setlocal noexpandtab softtabstop=4 tabstop=4 shiftwidth=4

"------ python indent ----------
au FileType python setlocal expandtab softtabstop=4 tabstop=4 shiftwidth=4

"------------ ctrlsf -------------
let g:ctrlsf_ackprg = 'rg'
let g:ctrlsf_auto_close = 0
nnoremap <leader>/ :CtrlSF<space>

" ----------- vim-visual-multi ------------
let g:VM_maps = {}
let g:VM_maps["Select Cursor Down"] = '<M-C-Down>'
let g:VM_maps["Select Cursor Up"]   = '<M-C-Up>'
nmap <C-LeftMouse> <Plug>(VM-Mouse-Cursor)
nmap <M-RightMouse> <Plug>(VM-Mouse-Word)
nmap <M-C-LeftMouse> <Plug>(VM-Mouse-Column)

" ----------- Terminal --------------
" Make escape work in the Neovim terminal.
" tnoremap <Esc> <C-\><C-n>
" set nonumber
autocmd TermOpen * setlocal conceallevel=0 colorcolumn=0 nonumber
" Prefer Neovim terminal insert mode to normal mode.
autocmd BufEnter term://* startinsert!

" Make navigation into and out of Neovim terminal splits nicer.
" tnoremap <C-h> <C-\><C-N><C-w>h
" tnoremap <C-j> <C-\><C-N><C-w>j
" tnoremap <C-k> <C-\><C-N><C-w>k
" tnoremap <C-l> <C-\><C-N><C-w>l

" source lua
lua require('init')
