
let s:path = expand('$CACHE/dein')
if !dein#load_state(s:path)
  finish
endif

call dein#begin(s:path, expand('<sfile>'))
call dein#load_toml('~/.vim/rc/dein.toml', {'lazy': 0})
call dein#load_toml('~/.vim/rc/dein_lazy.toml', {'lazy': 1})

call dein#add('~/dev/NeoVim/sample', {'name': 'sample'})

if has('nvim')
  call dein#load_toml('~/.vim/rc/dein_neo.toml', {})
endif

call dein#end()
call dein#save_state()

if !has('vim_starting') && dein#check_install()
  call dein#install()
endif
