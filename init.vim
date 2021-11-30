
" diable unused remote-plugins provider
let g:loaded_python_provider = 0 " disable python2 provider
let g:loaded_ruby_provider = 0
let g:loaded_perl_provider = 0

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
set updatetime=600
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

" 将光标移至行首
nnoremap H ^
" 将光标移至行尾
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

" 把 CTRL-S 映射为 保存
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
let g:vim_markdown_fenced_languages = ['bash=sh', 'ruby', 'javascript']
let g:vim_markdown_conceal = 0

"------------- telescope ------------
nnoremap <leader>f <cmd>Telescope find_files<cr>
nnoremap <leader>g <cmd>Telescope live_grep<cr>
nnoremap <leader>b <cmd>Telescope buffers<cr>
nnoremap <leader>t <cmd>Telescope coc document_symbols<cr>
nnoremap <D-p> <cmd>Telescope find_files<cr>
nnoremap <C-p> <cmd>Telescope find_files<cr>
nnoremap <D-S-p> <cmd>Telescope commands<cr>

"------------- Lazygit ------------
nnoremap <silent> <leader>lg :LazyGit<CR>

"--------- AnyJump --------{{{
let g:any_jump_grouping_enabled = 1
nnoremap <leader>j :AnyJump<CR>
"}}}
"
"--------- copilot --------{{{
imap <silent><script><expr> <C-l> copilot#Accept("\<CR>")
let g:copilot_no_tab_map = v:true

"------ golang is special ----------
au FileType go setlocal noexpandtab softtabstop=4 tabstop=4 shiftwidth=4

"------ python indent ----------
au FileType python setlocal expandtab softtabstop=4 tabstop=4 shiftwidth=4

"------------ ctrlsf -------------
let g:ctrlsf_ackprg = 'rg'
let g:ctrlsf_auto_close = 0
nnoremap <leader>/ :CtrlSF<space>

"-------- vim-cycle ====================================================== {{{
let g:cycle_no_mappings = 1
nnoremap <silent> <Plug>CycleFallbackNext <C-A>
nnoremap <silent> <Plug>CycleFallbackPrev <C-X>
nmap <silent> <c-a> <Plug>CycleNext
vmap <silent> <c-a> <Plug>CycleNext
nmap <silent> <c-x> <Plug>CyclePrev
vmap <silent> <c-x> <Plug>CyclePrev
let g:cycle_default_groups = [
      \ [['true', 'false']],
      \ [['yes', 'no']],
      \ [['on', 'off']],
      \ [['+', '-']],
      \ [['>', '<']],
      \ [['==', '!=']],
      \ [['and', 'or']],
      \ [["in", "out"]],
      \ [["up", "down"]],
      \ [["min", "max"]],
      \ [["get", "set"]],
      \ [["add", "remove"]],
      \ [["to", "from"]],
      \ [["read", "write"]],
      \ [["only", "except"]],
      \ [["exclude", "include"]],
      \ [["asc", "desc"]],
      \ [["first", "last"]],
      \ [["if", "unless"]],
      \ [["blank", "present"]],
      \ [["while", "until"]],
      \ [["foreign_key", "primary_key"]],
      \ [['是', '否']],
      \ [['":"', "':'"], 'sub_pairs'],
      \ [['{:}', '[:]', '(:)'], 'sub_pairs'],
      \ [['（:）', '「:」', '『:』'], 'sub_pairs'],
      \ [['Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday',
      \   'Friday', 'Saturday'], 'hard_case', {'name': 'Days'}],
      \ ]
" }}}

" ----------- nvim-tree ------------
let g:nvim_tree_indent_markers = 1
let g:nvim_tree_disable_window_picker = 1
nnoremap <leader>p :NvimTreeFindFileToggle<CR>


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

"----------------------- hlslens -------------------------------
noremap <silent> n <Cmd>execute('normal! ' . v:count1 . 'n')<CR>
            \<Cmd>lua require('hlslens').start()<CR>
noremap <silent> N <Cmd>execute('normal! ' . v:count1 . 'N')<CR>
            \<Cmd>lua require('hlslens').start()<CR>
noremap * *<Cmd>lua require('hlslens').start()<CR>
noremap # #<Cmd>lua require('hlslens').start()<CR>
noremap g* g*<Cmd>lua require('hlslens').start()<CR>
noremap g# g#<Cmd>lua require('hlslens').start()<CR>

" source lua
lua require('init')

" filetype on
