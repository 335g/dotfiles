export EDITOR=vim
export SHELL=zsh
export ZPLUG_HOME=$HOME/.zplug
export LANG=en_US.UTF-8
export XDG_CONFIG_HOME=$HOME/dotfiles/vim
export PYENV_ROOT=$HOME/.pyenv
export PATH=$PYENV_ROOT/bin:$HOME/.local/bin:/usr/local/bin:$PATH
export RUST_SRC_PATH=$HOME/.multirust/toolchains/stable-x86_64-apple-darwin/lib/rustlib/src/rust/src
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

source ~/.cargo/env
