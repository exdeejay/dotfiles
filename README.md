# .dot.files

these are my dotfiles, optimized for getting up and running on a new machine quickly. not totally complete yet, but there's some banger scripts in here.


## install

```bash
cd ~
git clone https://github.com/exdeejay/dotfiles .dotfiles
cd .dotfiles
./install.sh
```

## what's inside

```bash
non-dotfiles
---------------

.githooks/          # includes a hook that prevents commits from other accounts
backup/             # previously existing dotfiles are backed up here on install
bash_include/       # parts of .bashrc pulled into their own files
bin/                # some useful binaries for path (disabled on non-x86_64)
installmodules/     # things to install that require their own install method
    <module name>/
        check.sh        # exit code determines if we need to install this thing
        install.sh      # actually install the thing
scripts/            # shell scripts that are added to path
apt-dependencies    # common dependencies that are nice to have upon install
install.sh          # run to install dotfiles
uninstall.sh        # run to uninstall dotfiles that are from this directory
```

### tmux

sets up bash to use tmux by default, with a fancy UI. run `detach` in bash to disconnect from tmux and keep your session. run `attach` to reconnect to the tmux session.

new tmux sessions are started in group mode. this means that two different shells can use different windows in the same tmux session without messing each other up. there will still be only one cursor per window, however.

if the terminal you're using supports OSC 52, tmux copying and pasting will use the system clipboard!

#### plugins:
- `tmux-mode-indicator`: puts an indicator in the bottom right that shows what mode tmux is currently in (normal, command, copy, etc.)
- `tmux-suspend`: stop tmux from interpreting the command sequence (ctrl+B) in the top-level terminal. good for easily controlling remote tmux sessions through ssh without spamming the command sequence.

### bash

`.bash_profile` is run when a login session is started. it's mainly used for environment variables and not much else.

`.bashrc` is the main bash startup file. `.bash_profile` sources this file so that it's always run (NOTE: neither of these startup files will run if bash is invoked headlessly). it's split into several parts:

- `bash_include/path.sh`: path modifications should go here
- `bash_include/aliases.sh`: put your aliases here
- `bash_include/shopts.sh`: all shell options go here
- `bash_include/functions.sh`: helper functions go in here
- `bash_include/tmux.sh`: tmux functions `attach` and `detach`
- `bash_include/fzf-*.sh`: `fzf`-specific completion and such
- `bash_include/misc.sh`: anything else that doesn't really need its own place
- `~/.bash_include/`: every script in this folder will be run during shell startup

#### nice features:
- case-insensitive tab completion (from `.inputrc`)
- cd fixes small spelling mistakes
- ctrl+R will use `fzf` to search command history
- asciinema will record all terminal input and save it to a replay file in `.casts` (to disable this, delete the following line in `.bashrc`: `[[ -z "$RECORD" ]] && RECORD="yes"`)

### vim

#### plugins:
- `cheat40`: cheatsheet in vim (press `\?`)
- `ctrlp`: fuzzy finder file opener (press `ctrl+P`)
- `nerdtree`: file browser (run `:NERDTree`)
- `nginx.vim`: syntax highlighting for nginx files
- `tmux-complete.vim`: word completion for words in other tmux panes
- `undotree`: tree of undos (run `:UndotreeToggle`)
- `vim-oscyank`: yank to system clipboard through OSC 52 (press `\y` to yank)
- `python.vim`: custom, simply switches vim to use tabs instead of spaces for .py files


### gdb

`.gdbinit` just sets the disassembler to use intel syntax by default, and also makes `gdb-pwndbg` and `gdb-gef` commands for quickly launching either `pwndbg` or `gef` from normal gdb. these commands are also scripts if you want to start either one from the command line, and `gdb` is aliased to `gdb-pwndbg` by default in bash.

### binaries

TODO: switch between ARM and x86 binaries depending on the platform

- `ag`: like grep but for large codebases (`ag printf` to find all print statements in a directory)
- `bat`: fancy `cat`
- `fzf`: fuzzy search through files in a directory. mainly used for command completion, but you can also do `vim $(fzf)`


### scripts

please feel free to steal any of these scripts for your own dotfiles! 

- `gdb-gef`: launches GEF
- `gdb-pwndbg`: launches pwndbg
- `git-reauthor`: change ALL commits in a repository to be by the current author (preserves author and commit date)
- `lsa`: `ls` but you can see dotfiles easier
- `makereal`: changes a symbolic link to be a real file with the contents of the linked file
- `neofetch`: stock [neofetch](https://github.com/dylanaraps/neofetch), prints your system specs nicely
- `readYN`: helper script that prints a nice yes/no prompt for the user
- `switchgit`: stash/pop the current git user and switches it with `exdeejay` (hardcoded into the file)
- `untar`: smartly untars a tarball. if there's only one file/directory, untar as is. otherwise, make a directory and put all the untarred files in it.
- `wttr`: stock [wttr.in](https://github.com/chubin/wttr.in) script to check the weather
