"" basic configuration
filetype plugin indent on
set relativenumber number
set autoindent
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set ruler
set wrap
set splitright 
set noimdisable
set autochdir
set hlsearch
set backspace=indent,eol,start
set nofoldenable
colorscheme violet
set background=dark
set guioptions-=m
set guioptions-=T
set encoding=utf-8
set guifont=Cascadia\ Code\ 12
set lines=53 columns=211


"" disable screen flash and bell
set noeb vb t_vb= 
au GUIEnter * set vb t_vb=

"" vim-plug configuration
call plug#begin()
Plug 'bling/vim-bufferline'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'luochen1990/rainbow'
Plug 'majutsushi/tagbar'
Plug 'preservim/nerdtree'
Plug 'ludovicchabant/vim-gutentags'

Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'yggdroot/leaderf'
Plug 'kshenoy/vim-signature'

Plug 'dhruvasagar/vim-table-mode'
Plug 'skywind3000/vim-terminal-help'
Plug 'godlygeek/tabular'
Plug 'Meuhor/vlog_inst_gen'
Plug 'triglav/vim-visual-increment'
call plug#end()

"" key mapping
let mapleader=','
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
nnoremap <C-q> :q<CR>
"" map cd to current directory on "leader" + "."
nnoremap <silent> <leader>. :cd %:p:h<CR>
"" switch between tabs
noremap <leader><TAB> :bn<CR>
noremap <leader>n<TAB> :bp<CR>
" " coc multiple cursors configuration
" nmap <expr> <silent> <C-d> <SID>select_current_word()
" function! s:select_current_word()
"   if !get(g:, 'coc_cursors_activated', 0)
"     return "\<Plug>(coc-cursors-word)"
"   endif
"   return "*\<Plug>(coc-cursors-word):nohlsearch\<CR>"
" endfunc

"" clipboard keybinding
vmap <leader>y "+y
vmap <leader>p <ESC>"+p
imap <leader>p <C-r><C-o>+
nmap <leader>p "+p

nmap <leader>g :nohls<CR>

"" rainbow configuration
let g:rainbow_active=1

"" vim-commentary configuration
autocmd FileType python,shell,coffee set commentstring=#\ %s
autocmd FileType c,cpp,java,verilog,systemverilog,json set commentstring=//\ %s

"" NERDTree configuration
let g:tagbar_left     = 0
let g:tagbar_vertical = 25
let NERDTREEWinPos    = 'left'
noremap wm :NERDTreeToggle<CR> :TagbarToggle<CR> :wincmd p<CR>

"" leaderF configuartion
let g:Lf_WindowPosition = 'popup'
noremap <leader>fl :<C-U><C-R>=printf("Leaderf line %s", "")<CR><CR>


"" header descriptions
autocmd BufNewFile *.c,*.cpp,*.sh,*.lua,*.rst,*.v,*.sv exec ":call SetHeaderDescription()"
function SetHeaderDescription()
	call setline(1,            "Copyright (C) ".strftime("%Y")." All rights reserved.")
	call append(line("."),     "FileName      : ".expand("%"))
	call append(line(".") + 1, "Author        : meuhor")
	call append(line(".") + 2, "Email         : meuhor@foxmail.com")
	call append(line(".") + 3, "Date          : ".strftime("%Y-%m-%d"))
	call append(line(".") + 4, "Description:  : ")
	normal 6gccGA
endfunction

"" <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<< coc configuartion
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<< coc configuartion end

" gutentags configuartion
" gutentags搜索工程目录的标志，碰到这些文件/目录名就停止向上一级目录递归 "
let g:gutentags_project_root = ['.root', '.svn', '.git', '.project']

" 所生成的数据文件的名称 "
let g:gutentags_ctags_tagfile = '.tags'

" 将自动生成的 tags 文件全部放入 ~/.cache/tags 目录中，避免污染工程目录 "
let s:vim_tags = expand('~/.cache/tags')
let g:gutentags_cache_dir = s:vim_tags
" 检测 ~/.cache/tags 不存在就新建 "
if !isdirectory(s:vim_tags)
   silent! call mkdir(s:vim_tags, 'p')
endif

" 配置 ctags 的参数 "
let g:gutentags_ctags_extra_args = ['--fields=+niazS', '--extra=+q']
let g:gutentags_ctags_extra_args += ['--c++-kinds=+pxI']
let g:gutentags_ctags_extra_args += ['--c-kinds=+px']


" Verilog AddAlways functions
nnoremap Alpp :Alpp<CR><CR>
nnoremap Alpn :Alpn<CR><CR>
nnoremap Alnp :Alnp<CR><CR>
nnoremap Alnn :Alnn<CR><CR>
nnoremap Alp  :Alp<CR><CR>
nnoremap Aln  :Aln<CR><CR>
nnoremap Al   :Al<CR><CR>

command Alpp :call vfunc#AddAlways("posedge", "posedge")
command Alpn :call vfunc#AddAlways("posedge", "negedge")
command Alnp :call vfunc#AddAlways("negedge", "posedge")
command Alnn :call vfunc#AddAlways("negedge", "negedge")
command Alp  :call vfunc#AddAlways("posedge", "")
command Aln  :call vfunc#AddAlways("negedge", "")
command Al   :call vfunc#AddAlways("", "")

" " Meuhor define user functon
command -nargs=* Numberized :call Numberized(<f-args>)
function Numberized(...)	
	if a:0 == 0
		echom "wrong variables"
	elseif a:0 == 1
		let startnum = 0
		let step = 1
	elseif a:0 == 2
		let step = a:2
	elseif a:0 == 3
		let startnum = a:2
		let step = a:3
	endif
	let pattern = a:1
	let cmd = ":let i=" . startnum . " | g/" . pattern . "\\zs\\d\\+/s//\\=i/" . "| let i+=" . step
	echom cmd
	exec cmd
endfunction

" define line highlight color
highlight LineHighlight ctermbg=darkgray guibg=darkgray

" highlight the current line
nnoremap <silent> <Leader>l :call matchadd('LineHighlight', '\%'.line('.').'l')<CR>

" clear all the highlighted lines
nnoremap <silent> <Leader>c :call clearmatches()<CR>

