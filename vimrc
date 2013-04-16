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
