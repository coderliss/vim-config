"term
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

"common
syntax on
set nocp
set backup
set hlsearch
set number
set history=1000
set autoindent
"set expandtab
set tabstop=4
set shiftwidth=4
colorscheme desert
filetype plugin indent on 

"file format
set fileformats=unix,dos

"keys
set backspace=indent,eol,start

"Complete type
set completeopt=longest,menu

"CTags 
map <C-F12> :!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<CR>
set tags+=/opt/liss/aimcpro1.5/tags
set tags+=$HOME/.vim/tags/cpp
set tags+=$HOME/.vim/tags/apl
set tags+=$HOME/.vim/tags/acl
set tags+=$HOME/.vim/tags/anf
set tags+=$HOME/.vim/php/doc/tags

" php runtimepath
set runtimepath+=$HOME/.vim/php
autocmd BufNewFile,Bufread *.ros,*.inc,*.php set keywordprg="help"

"complete func
autocmd FileType ruby,eruby set omnifunc=rubycomplete#Complete
autocmd FileType python set omnifunc=pythoncomplete#Complete
autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
autocmd FileType css set omnifunc=csscomplete#CompleteCSS
autocmd FileType java set omnifunc=javacomplete#Complet
"autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
"autocmd FileType xml set omnifunc=xmlcomplete#CompleteTags

"OmniCpp complete
let OmniCpp_NamespaceSearch = 1
let OmniCpp_GlobalScopeSearch = 1
let OmniCpp_MayCompleteScope = 1
let OmniCpp_SelectFirstItem = 1
let OmniCpp_ShowPrototypeInAbbr = 1
let OmniCpp_MayCompleteScope = 1
inoremap <expr> <CR>       pumvisible()?"\<C-Y>":"\<CR>"
inoremap <expr> <C-J>      pumvisible()?"\<PageDown>\<C-N>\<C-P>":"\<C-X><C-O>"
inoremap <expr> <C-K>      pumvisible()?"\<PageUp>\<C-P>\<C-N>":"\<C-K>"
inoremap <expr> <C-U>      pumvisible()?"\<C-E>":"\<C-U>"

"taglist
let Tlist_Ctags_Cmd="ctags"
let Tlist_Sort_Type="name"
let Tlist_Exit_OnlyWindow=1
let Tlist_File_Fold_Auto_Close=1
let Tlist_Auto_Open=0
set updatetime=1000
map <F2> : TlistOpen<CR>

"winmanager
let g:winManagerWindowLayout='FileExplorer|TagList'
map <F4> :WMToggle<CR>

"csope
set cscopequickfix=s-,c-,d-,i-,t-,e-
map <C-F11> :!cscope -R <CR>

"split
map   <F8> :vert res +10<ENTER>
imap  <F8> <ESC>:vert res +10<ENTER>
map   <F9> :vert res -10<ENTER>
imap  <F9> <ESC>:vert res -10<ENTER>

"python complete
let g:pydiction_location = '$HOME/.vim/after/ftplugin/pydiction/complete-dict'
"let g:pydiction_menu_height = 20

"dict complete
"set dict=$HOME/.vim/after/ftplugin/pydiction/complete-dict

"Record cursor position
au BufReadPost * if line("'\"") > 0|if line("'\"") <= line("$")|exe("norm '\"")|else|exe "norm $"|endif|endif

"mutt
au BufRead /tmp/mutt-* set tw=72