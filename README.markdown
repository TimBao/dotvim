# Files
.vim directory of file type configurations and plugins .vimrc my vim configuration.

## Install Detail

1. git clone http://github.com/TimBao/dotvim.git ~/.vim
1. ln -s ~/.vim/vimrc ~/.vimrc
1. cd ~/.vim
1. git submodule init
1. git submodule update

### Update Plugin

1. cd ~/.vim/bundle/vim-markdown  # Replace vim-markdown to your plugin name
1. git pull origin master

----

1. cd ~/.vim
1. git submodule foreach git pull origin master

### Delete Plugin

> git rm bundle/vim-markdown  # Replace vim-markdown to your plugin name
