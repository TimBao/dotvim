# Files
.vim directory of file type configurations and plugins .vimrc my vim configuration.

## Install Detail

1. git clone http://github.com/TimBao/dotvim.git ~/.vim
1. ln -s ~/.vim/vimrc ~/.vimrc
1. cd ~/.vim
1. git submodule init
1. git submodule update

----
### on Windows

1. cd $vim
1. git clone http://github.com/TimBao/dotvim.git ./vimfiles
1. mklink \_vimrc vimfiles/vimrc
1. cd vimfiles
1. git submodule init
1. git submodule update

---
1. If you want to support chinese font, please change encodding to cp936

### Update Plugin

1. cd ~/.vim/bundle/vim-markdown  # Replace vim-markdown to your plugin name
1. git pull origin master

----

1. cd ~/.vim
1. git submodule foreach git pull origin master

### Add new Plugin
1. git submodule add XXX.git bundle/XXX
2. git add .gitmodule
3. git commit -m "add XXX plugin"
4. git push origin master

### Delete Plugin

> git rm bundle/vim-markdown  # Replace vim-markdown to your plugin name
