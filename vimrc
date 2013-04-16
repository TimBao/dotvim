" Common setting for vim
let mapleader = ","

" Plugin of pathogen.vim setting
runtime bundle/vim-pathogen/autoload/pathogen.vim
call pathogen#infect()
"call pathogen#runtime_append_all_bundles()
call pathogen#helptags()

" Plugin of NERDTree.vim setting
nmap <silent> <leader>fe :Vexplore<cr>
nmap <silent> <leader>nt :NERDTreeToggle<cr>

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
