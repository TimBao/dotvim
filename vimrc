" Common setting for vim
syntax enable                       "Syntax highlighting
syntax on
colorscheme torte                   "Color scheme

set nowinfixwidth
set number                          "Show line number
set nocompatible                    "Close compatible model

" set autoindent                      "Copy indent from current line when starting a new line
" set smartindent
" C code format
set cinoptions=:0,p0,t0
set cinwords=if,else,while,do,for,switch,case
set formatoptions=tcqr
set cindent

set autoread                        "Automatically read it after file be changed outside of Vim
set showmatch                       "When a bracket is inserted, briefly jump to the matching one
set nobackup                        "Not backup file before overwriting a file
set noswapfile                      "Not swap file
set hlsearch                        "Highlighting of search matches
set incsearch                       "Incremental searching
set backspace=2                     "Influences the working of <BS>, <Del>, CTRL-W and CTRL-U in Insert mode

set tabstop=4                       "Number of spaces that a <Tab> in the file counts for
set shiftwidth=4                    "Number of spaces to use for each step of (auto)indent
set expandtab                       "Tabs expanded to spaces
set list listchars=tab:>- ":retab   "Show tab as >-, use retab to clean up wihte space

set cursorline                      "Highlight the screen line of the cursor with CursorLine
set cursorcolumn                    "Highlight the screen column of the cursor with CursorColumn
"Convert Hightlight cursorline to underline
hi cursorline guibg=NONE gui=underline

set ruler                           "Show the line and column number of the cursor position, separated by a comma. See statusline.
set laststatus=2                    "Always show statusline.
set statusline=%h%=%-14.(%l,%c%V%)\%<%p%%\\\%{strftime('%y-%m-%d\ %A')}

set encoding=utf-8
set fileencodings=utf-8,gb2312,gbk,gb18030,latin-1
set fileencoding=utf-8

set autochdir                       "Set auto change current work folder.

let mapleader = "," 
"search in document
nnoremap <silent> <F3> :lv /\<<c-r>=expand("<cword>")<CR>\>/j %<CR>:lw<CR>
nnoremap <silent> <F4> :lv /\<TODO\>/j ./**/*.cpp<CR>:lw<CR>
"switch windows
nnoremap <silent> <C-Tab> <C-W>w
"open setting preference
if has('win32')
    map <leader>ee :e $vim/_vimrc<CR>
else
    noremap <leader>ee :e ~/.vimrc<CR>
endif

"compile single file
"au FileType c set makeprg=gcc\ %
"au FIleType cpp set makeprg=g++ %

if has("gui_win32")
    au GUIEnter * simalt ~x
elseif has("gui_macvim")
    au GUIEnter * call MaximizeWindow()
    "Set the guifont only for macvim
    set guifont=Menlo:h15
else
    au GUIEnter * call MaximizeWindow()
endif

" Need to install wmctrl.
function! MaximizeWindow()
    silent !wmctrl -r :ACTIVE: -b add,maximized_vert,maximized_horz
endfunction

function! RemoveTrailingWhitespace()
    if &ft != "diff"
        let b:curcol = col(".")
        let b:curline = line(".")
        "remove only current line.
        silent! .s/\s\+$//
        silent! .s/\(\s*\n\)\+\%$//
        " remove all lines.
        "silent! %s/\s\+$//
        "silent! %s/\(\s*\n\)\+\%$//
        call cursor(b:curline, b:curcol)
    endif
endfunction
autocmd BufWritePre * call RemoveTrailingWhitespace()

nmap <F5> :CopyDefinition<CR>
nmap <F6> :ImplementDefinition<CR>
command! CopyDefinition :call s:GetDefinitionInfo()
command! ImplementDefinition :call s:ImplementDefinition()
function! s:GetDefinitionInfo()
    exe 'normal ma'
    " Get class
    call search('^\s*\<class\>', 'b')
    exe 'normal ^w"ayw'
    let s:class = @a
    let l:ns = search('^\s*\<namespace\>', 'b')
    " Get namespace
    if l:ns != 0
    exe 'normal ^w"ayw'
    let s:namespace = @a
    else
    let s:namespace = ''
    endif
    " Go back to definition
    exe 'normal `a'
    exe 'normal "aY'
    let s:defline = substitute(@a, ';\n', '', '')
    endfunction

function! s:ImplementDefinition()
    call append('.', s:defline)
    exe 'normal j'
    " Remove keywords
    s/\<virtual\>\s*//e
    s/\<static\>\s*//e
    if s:namespace == ''
    let l:classString = s:class . "::"
    else
    let l:classString = s:class . "::"
    "let l:classString = s:namespace . "::" . s:class . "::"
    endif
    " Remove default parameters
    s/\s\{-}=\s\{-}[^,)]\{1,}//e
    " Add class qualifier
    exe 'normal ^f(bi' . l:classString
    " Add brackets
    exe "normal $o{\<CR>\<TAB>\<CR>}\<CR>\<ESC>kkkk"
    " Fix indentation
    exe 'normal =4j^'
endfunction

if &diff
    nnoremap <F7> [c
    nnoremap <F8> ]c
else
    map <F7> :cp<CR>
    map <F8> :cn<CR>
endif

:source $VIMRUNTIME/ftplugin/man.vim
nmap <leader>m :Man 3 <cword><CR>
"------------------------------------------------------------------

" Plugin of pathogen.vim setting
runtime bundle/vim-pathogen/autoload/pathogen.vim
call pathogen#infect()
call pathogen#helptags()

" Some plugin need open the filetype
filetype on
filetype plugin on

" Plugin of NERDTree.vim setting
nmap <silent> <leader>fe :Vexplore<CR>
nmap <silent> <leader>nt :NERDTreeToggle<CR>
let NERDTreeWinSize = winwidth(0)/2

" Plugin of taglist.vim setting
let Tlist_Show_One_File=1
let Tlist_Exit_OnlyWindow=1
if !has('win32')
    let Tlist_Ctags_Cmd = '/opt/local/bin/ctags'
endif
nmap <silent> <leader>fl :Tlist<CR>

" Plugin of winmanager.vim setting
let g:winManagerWindowLayout='FileExplorer|TagList'
nmap wm :WMToggle<CR>

" Plugin of OmniCppComplete.vim setting
if has('win32')
    set tags+=$vim/vimfiles/ctags/cpp
    set tags+=$vim/vimfiles/ctags/code_tags
else
    set tags+=~/.vim/ctags/cpp
    set tags+=~/.vim/ctags/code_tags
endif
"set tags+=~/.vim/tags/gl
"set tags+=~/.vim/tags/sdl
"set tags+=~/.vim/tags/qt4
" build tags of your own project with Ctrl-F12
map <C-F12> :!ctags -R --sort=yes --c++-kinds=+p --fields=+iaS --extra=+q .<CR>

let OmniCpp_NamespaceSearch = 1
let OmniCpp_GlobalScopeSearch = 1
let OmniCpp_ShowAccess = 1
let OmniCpp_ShowPrototypeInAbbr = 1 " show function parameters
let OmniCpp_MayCompleteDot = 1 " autocomplete after .
let OmniCpp_MayCompleteArrow = 1 " autocomplete after ->
let OmniCpp_MayCompleteScope = 1 " autocomplete after ::
let OmniCpp_DefaultNamespaces = ["std", "_GLIBCXX_STD"]
" automatically open and close the popup menu / preview window
au CursorMovedI,InsertLeave * if pumvisible() == 0|silent! pclose|endif
set completeopt=menuone,menu,longest,preview

" Plugin of ConqueTerm.vim setting
if has("win32")
    noremap <leader>sh :ConqueTerm PowerShell.exe<CR>
    noremap <leader>shs :ConqueTermSplit PowerShell.exe<CR>
    noremap <leader>shv :ConqueTermVSplit PowerShell.exe<CR>
    noremap <leader>sht :ConqueTermTab PowerShell.exe<CR>
else
    noremap <leader>sh :ConqueTerm bash<CR>
    noremap <leader>shs :ConqueTermSplit bash<CR>
    noremap <leader>shv :ConqueTermVSplit bash<CR>
    noremap <leader>sht :ConqueTermTab bash<CR>
endif

if has('win32')
    let g:ConqueTerm_PyVersion = 2
    let g:ConqueTerm_PyExe = 'C:\Python27\python.exe'
    let g:ConqueTerm_ColorMode = 'conceal'
    let g:ConqueTerm_CodePage = 0
else
    let g:ConqueTerm_FastMode = 0
    let g:ConqueTerm_Color = 1
    let g:ConqueTerm_TERM = 'xterm'
    let g:ConqueTerm_Syntax = 'conque'
    let g:ConqueTerm_ReadUnfocused = 1
endif

" Plugin of python_pydiction.vim setting
let g:pydiction_menu_height = 20
if has('win32')
    let g:pydiction_location='$vim/vimfiles/bundle/PyDiction/complete-dict'
else
    let g:pydiction_location='~/.vim/bundle/PyDiction/complete-dict'
endif

" Plugin of a.vim setting
let g:alternateExtensions_CPP = "inc,h,H,HPP,hpp"

" Plugin of snipMate.vim setting
if has('win32')
    let g:snippets_dir='$vim/vimfiles/bundle/SnipMate/snippets'
else
    let g:snippets_dir='~/.vim/bundle/SnipMate/snippets'
endif

" Plugin of EasyMotin.vim setting
"let g:EasyMotion_leader_key = '<leader>'
map <Leader> <Plug>(easymotion-prefix)

" Plugin of ctrlp.vim setting 
if has('win32')
    set runtimepath^=$vim/vimfiles/bundle/ctrlp.vim
else
    set runtimepath^=~.vim/bundle/Ctrlp
endif

" Add cscope db
if has('cscope')
    set nocsverb
    if !has('win32') && exists("$HOME/.vim/CSCOPEDB/cscope.out")
        cs add ~/.vim/CSCOPEDB/cscope.out
    endif
    set csverb
endif
