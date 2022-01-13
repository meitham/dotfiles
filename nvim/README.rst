===
VIM
===

This is a shared configuration across ``vim`` anv ``nvim`` using ``XDG`` as the default layout.

``NVIM`` will work out of the box with this, however ``VIM`` needs a ``~/.vimrc`` with the following content:


  set runtimepath^=~/.config/nvim runtimepath+=~/.config/nvim/after
  let &packpath=&runtimepath
  source ~/.config/nvim/vimrc
