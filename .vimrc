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
set autoindent
set expandtab
set tabstop=3
set shiftwidth=3
set t_Co=256
"colorscheme desert
"colorscheme desert256
colorscheme vombatidae
filetype plugin indent on 
set clipboard=unnamed
set mouse=a
set pastetoggle=<F3>

"file format
set fileformats=unix,dos

"keys
set backspace=indent,eol,start

"Complete type
set completeopt=longest,menu

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

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'Valloric/YouCompleteMe'
Plugin 'lyuts/vim-rtags'
call vundle#end()

" YouCompleteMe
"let g:loaded_youcompleteme = 1
let g:ycm_confirm_extra_conf = 0
let g:ycm_enable_diagnostic_signs=0
let g:ycm_extra_conf_globlist = ['.','../', '../../', '../../../', '../../../../', '../../../../../', '../../../../../../', '../../../../../../../']
function! s:setup_ycm()
   nnoremap gh :YcmCompleter GoToDeclaration<CR>
   nnoremap gi :YcmCompleter GoToDefinition<CR>
   nnoremap gf :YcmCompleter FixIt<CR>
   nnoremap <c-]> :YcmCompleter GoToDefinitionElseDeclaration<CR>
   nnoremap <c-t> <c-o>
endfunction

"rtags
let g:rtagsUseDefaultMappings = 0 
let g:rtagsRcCmd = 'rc --socket-file=/$HOME/.rdm'
function! s:setup_rtags()
   nnoremap gr :call rtags#FindRefs()<CR>
   nnoremap gc :call rtags#FindSubClasses()<CR>
   nnoremap gC :call rtags#FindSuperClasses()<CR>
   nnoremap gv :call rtags#FindVirtuals()<CR>
   noremap <F5> :call rtags#ReindexFile()<CR>
   cnoreabbrev rename call rtags#RenameSymbolUnderCursor()<CR>
   nnoremap gh :call rtags#JumpTo(g:SAME_WINDOW, { '--declaration-only' : '' })<CR>
   nnoremap <c-]> :call rtags#JumpTo(g:SAME_WINDOW)<CR>
   nnoremap <c-t> :call rtags#JumpBack()<CR>
endfunction

autocmd FileType cpp call s:setup_rtags()
autocmd FileType c call s:setup_rtags()
autocmd FileType python call s:setup_ycm()
