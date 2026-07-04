[alias]
     co = checkout
     c = commit --verbose
     cm = commit -m
     s = -p status -sb
     last = log -1 HEAD –stat
     graph = log --oneline --graph --decorate
     gr = graph
     root = rev-parse --show-toplevel
     br = branch --no-column --format='%(HEAD) %(if:equals="refs/heads")%(refname:rstrip=-2)%(then)%(color:yellow)%(else)%(color:red)%(end)%(refname:short)%(color:reset)%(if:equals=">")%(upstream:trackshort)%(then) %(color:brightgreen)%(end)%(if:equals="<")%(upstream:trackshort)%(then) %(color:brightred)%(end)%(if:equals="<>")%(then) %(color:brightcyan)%(end)%(upstream:track)%(color:reset) - %(contents:subject) %(color:green)(%(committerdate:relative)) [%(authorname)]' --sort=-committerdate
     out = log @{u}..
     mb = "!git reset $(git merge-base $(git rev-parse --abbrev-ref origin/HEAD) HEAD)"
[branch]
     sort = -committerdate
[tag]
     sort = version:refname
[diff]
     algorithm = histogram
     colorMoved = plain
     mnemonicPrefix = true
     renames = true
[push]
     default = simple
     autoSetupRemote = true
[fetch]
     prune = true
     pruneTags = true
     all = true
[help]
     autocorrect = prompt
[commit]
     verbose = true
[rebase]
     autoSquash = true
     autoStash = true
     updateRefs = true
[merge]
     conflictStyle = zdiff3
[pull]
     rebase = true
[submodule]
     recurse = true
[user]
	name = exdeejay
	email = 13634296+exdeejay@users.noreply.github.com
