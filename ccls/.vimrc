if &term =~ "xterm" || &term =~ "vt100" || &term =~ "ansi"
  if has("terminfo")
        set t_Co=8
        set t_Sf=[3%p1%dm
        set t_Sb=[4%p1%dm
  else
        set t_Co=8
        set t_Sf=[3%dm
        set t_Sb=[4%dm
  endif
endif 

syntax on
set nocp
"set backup
set hlsearch
set number
set history=1000
set viminfo='1000,<800
set smartindent
set expandtab
set tabstop=3
set shiftwidth=3
set t_Co=256
"colorscheme desert
"colorscheme desert256
colorscheme vombatidae
filetype plugin indent on 
set clipboard=unnamed
"set mouse=n
set pastetoggle=<F3>
set listchars=tab:>.
"set list
set encoding=utf-8


" Show trailing whitepace and spaces before a tab:
:highlight ExtraWhitespace ctermbg=red guibg=red
:autocmd Syntax * syn match ExtraWhitespace /\s\+$\| \+\ze\t/

"file format
set fileformats=unix,dos

"keys
set backspace=indent,eol,start

"Complete type
set completeopt=preview,longest,menu

"CTags {
    " This will look in the current directory for 'tags', and work up the tree towards root until one is found. 
    set tags=./tags;/,
    set tags+=$HOME/.vim/tags/cpp
    map <C-F12> :!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q --exclude=*.js --exclude=*.sql .<CR>
"}

" php runtimepath
autocmd BufNewFile,Bufread *.ros,*.inc,*.php set keywordprg="help"

"taglist
let Tlist_Ctags_Cmd="ctags"
let Tlist_Sort_Type="name"
let Tlist_Exit_OnlyWindow=1
let Tlist_File_Fold_Auto_Close=1
let Tlist_Auto_Open=0
set updatetime=1000
noremap <c-]> g<c-]>
map <F2> : TlistOpen<CR>

"winmanager
"let g:winManagerWindowLayout='FileExplorer|TagList'
let g:winManagerWindowLayout='TagList'
map <F4> :WMToggle<CR>

"csope
set cscopequickfix=s-,c-,d-,i-,t-,e-
map <C-F11> :!cscope -R <CR>

"split
map   <F8> :vert res +10<ENTER>
imap  <F8> <ESC>:vert res +10<ENTER>
map   <F9> :vert res -10<ENTER>
imap  <F9> <ESC>:vert res -10<ENTER>

"Record cursor position
au BufReadPost * if line("'\"") > 0|if line("'\"") <= line("$")|exe("norm '\"")|else|exe "norm $"|endif|endif

"mutt
au BufRead /tmp/mutt-* set tw=72

"python
autocmd FileType python nmap <c-k> :silent !open dash://python2:<cword><cr>
autocmd FileType python nmap <buffer> <c-r> :w<CR>:!/usr/bin/env python % <CR>
autocmd FileType c nmap <c-k> :silent !open dash://C:<cword><cr>
autocmd FileType cpp nmap <c-k> :silent !open dash://CPP:<cword><cr>
autocmd FileType cc nmap <c-k> :silent !open dash://CPP:<cword><cr>

call plug#begin('~/.vim/bundle')
Plug 'prabirshrestha/async.vim'
Plug 'prabirshrestha/vim-lsp'
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/asyncomplete-lsp.vim'
Plug 'ryanolsonx/vim-lsp-python'
call plug#end()

function! s:setup_ccls()
	" Register ccls C++ lanuage server.
	if executable('ccls')
		au User lsp_setup call lsp#register_server({
			\ 'name': 'ccls',
			\ 'cmd': {server_info->['ccls']},
			\ 'root_uri': {server_info->lsp#utils#path_to_uri(lsp#utils#find_nearest_parent_file_directory(lsp#utils#get_buffer_path(), 'compile_commands.json'))},
			\ 'initialization_options': {'cache': {'directory': '/tmp/ccls/cache' }},
			\ 'whitelist': ['c', 'cpp', 'objc', 'objcpp', 'cc'],
			\ })
	endif

   nnoremap gr :LspReferences<CR>
   nnoremap gv :LspImplementation<CR>
   nnoremap gv :LspImplementation<CR>
   cnoreabbrev rename LspRename<CR>
   nnoremap gh :LspDeclaration<CR>
   nnoremap <c-]> :LspDefinition<CR>
endfunction

autocmd FileType cpp call s:setup_ccls()
autocmd FileType c call s:setup_ccls()
autocmd FileType python call s:setup_ccls()
