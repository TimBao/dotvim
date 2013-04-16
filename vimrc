" Common setting for vim
let mapleader = ","

" Plugin of pathogen.vim setting
runtime bundle/vim-pathogen/autoload/pathogen.vim
call pathogen#infect()
"call pathogen#runtime_append_all_bundles()
call pathogen#helptags()

" Plugin of NERDTree.vim setting
nmap <silent> <leader>fe :Vexplore<CR>
nmap <silent> <leader>nt :NERDTreeToggle<CR>

" Plugin of taglist.vim setting
let Tlist_Show_One_File=1
let Tlist_Exit_OnlyWindow=1
nmap <silent> <leader>fl :Tlist<CR>

" Plugin of winmanager.vim setting
let g:winManagerWindowLayout='FileExplorer|TagList'
nmap wm :WMToggle<CR>

" Plugin of OmniCppComplete.vim setting
set tags+=~/.vim/ctags/cpp
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
noremap <leader>sh :ConqueTerm bash<CR>
noremap <leader>shs :ConqueTermSplit bash<CR>
noremap <leader>shv :ConqueTermVSplit bash<CR>
noremap <leader>sht :ConqueTermTab bash<CR>

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
filetype plugin on
let g:pydiction_menu_height = 20
let g:pydiction_location='~/.vim/bundle/PyDiction/complete-dict'
