alias g='git'

alias ga='git add'
alias gaa='git add --all'

alias gb='git branch' # list local branches
alias gba='git branch --all' # list local and remote branches
alias gbr='git branch --remote' # list remote branches only
alias gbm='git branch --move' # rename branch (current branch to <name> or <old_branch> to <name>)
alias gbd='git branch --delete' # delete local branch

alias gbs='git bisect' # looking for latest commit which is working
alias gbss='git bisect start' # start looking for working commmit (bisect session)
alias gbsr='git bisect reset' # end bisect session (return to state before start)
alias gbsb='git bisect bad' # label commit as bad (git checkout to next)
alias gbsg='git bisect good' # label commit as good (git checkout to next)

alias gc='git commit'
alias gcam='git commit --all --message'
alias gca='git commit --verbose --all'
alias gcn='git commit --verbose --no-edit'

alias gco='git checkout' # switch to diffrent branch
alias gcb='git checkout -b' # create new branch and switch to it
alias gcB='git checkout -B' # reset/override existing branch and switch to it
alias gcor='git checkout --recurse-submodules' # switch branch with auto submodule update

alias gcp='git cherry-pick' # get commit (by hash) from other branch and try to merge to current
alias gcpa='git cherry-pick --abort' # abort merging cherry-piced commit
alias gcpc='git cherry-pick --continue' # continue merging after solving conflicts at stagging area

alias gcl='git clone --recurse-submodules' # clone with updating submodules
alias gclf='git clone --recursive --shallow-submodules --filter=blob:none --also-filter-submodules' # for large projects

alias gcf='git config --list' # display all configs for current context
alias gclean='git clean --interactive -d' # interactive cleaning working tree from untracking files
alias gcount='git shortlog --summary --numbered' # displays list of people working for this repo

alias gd='git diff' # files modified in working tree (before git add)
alias gdw='git diff --word-diff' # words and letters, not lines only
alias gdca='git diff --cached' # files modified in staging area (after git add, before commit)
alias gdcw='git diff --cached --word-diff' # words and letters, not lines only
alias gds='git diff --staged' # same as --cached

alias gdct='git describe --tags $(git rev-list --tags --max-count=1)' # print info about last tag in repo

alias gf='git fetch' # fetch remote repo (but not merge changes)
alias gfa='git fetch --all --tags --prune --jobs=10' # download from all remote, tags, remove local branches that do not have a remote counterpart in 10 threads
alias gfo='git fetch origin' # fetch remote repo (named origin)

alias glo='git log --oneline --decorate' # list of commits with hash, message, tag
alias glog='git log --oneline --decorate --graph' # graph of commits with hash, message, tag
alias gloga='git log --oneline --decorate --graph --all' # graph of commits with all info
alias glg='git log --stat' # list of commits with info about author, date, message, changed lines
alias glgp='git log --stat --patch' # list of commits with full info about each one
alias glgg='git log --graph' # graph of commits
alias gwch='git log --patch --abbrev-commit --pretty=medium --raw' # 7-10 char hash, author, date, message, file modifications, paths

alias gl='git pull' # fetch from remote and merge to current branch (creating single merge commit)
alias gpr='git pull --rebase' # fetch from remote and merge to current branch (moving current branch commits to the top)
alias gprv='git pull --rebase -v' # verbose rebase
alias gpra='git pull --rebase --autostash' # same but with auto stash and unstash for uncommited changes
alias gprav='git pull --rebase --autostash -v' # same but verbose

alias gm='git merge' # merge given branch to current
alias gma='git merge --abort' # abort merging (conflicts solving)
alias gmc='git merge --continue' # continue merging after conflicts solved
alias gmff='git merge --ff-only' # fast-forward merge, merge only if there is linear history (no independent commits, or fail) 
alias gms='git merge --squash' # add all fetched data to staging area for one commit from all changes

alias gp='git push' # push changes to remote repo
alias gpv='git push --verbose' # verbose push
alias gpd='git push --dry-run' # push symulation
alias gpf='git push --force-with-lease --force-if-includes' # force push only if the upstram branch is same as local (you have all commits from remote, and no new changes was pushed by someone)
alias gpoat='git push origin --all && git push origin --tags' # push all local branches and all tags
alias gpod='git push origin --delete' # delete branch on upstream
alias gpu='git push upstream' # push to upstream, not your fork

alias grh='git reset' # return files from staging area to working tree
alias gru='git reset --' # for defined files, move them from staging area to working tree
alias grhs='git reset --soft' # remove everything to defined commit and move it's changes to working tree (leaves staging area unchanged)
alias grhk='git reset --keep' # remove everything to defined commit, but try to keep local changes (abort if not possible)
alias grhh='git reset --hard' # remove everything from HEAD to defined commit (removes also changes in working tree and staging area)

alias gr='git remote'
alias gra='git remote add' # add new remote repo (gra origin <url>)
alias grmv='git remote rename' # change remote repo name
alias grrm='git remote remove' # remove remote repo address
alias grup='git remote update' # update info of each remote repo
alias grv='git remote --verbose' # print list of remote repos with full addresses
alias grset='git remote set-url' # change remote repo address

alias grb='git rebase'
alias grbi='git rebase --interactive' # interactive rebase provide possibility to squash(join), reorder, edit message or delete commits
alias grbo='git rebase --onto' # provide option to copy commits from other branch on new base
alias grba='git rebase --abort' # stop rebase and return to state before rebase
alias grbc='git rebase --continue' # continue rebase after conflicts solved and added
alias grbs='git rebase --skip' # skip commit which has unsolvable conflict while rebase

alias grev='git revert' # create commit with undo changes in defined commit
alias greva='git revert --abort' # abort reverting
alias grevc='git revert --continue' # continue revert after conflicts solved and added

alias grf='git reflog' # show register of each move and command in git

alias grm='git rm' # remove file from git and filesystem
alias grmc='git rm --cached' # remove file from staging area and git track

alias grs='git restore'
alias grst='git restore --staged' # remove file from staging area (reverse git add)
alias grss='git restore --source' # revert file from given source (commit hash)

alias gsh='git show' # info about commit (last or given by hash or alias)
alias gshs='git show --stat' # only changed files in commit
alias gsps='git show --pretty=short --show-signature' # short version

alias gst='git status' # status of changed files, commits, added files (all about local repo changes)
alias gss='git status --short' # short version with files listen only
alias gsb='git status --short --branch' # short version plus info about branch (name and relation with remote)
alias gsnut='git status --untracked-files=no' # skip untraced filed (for big repos)

alias gsta='git stash push' # push changes to stack (you can name them: -m "name")
alias gstp='git stash pop' # pop changes from stack and merge with current changes
alias gstaa='git stash apply' # copy last stashed changes and merge with current (do not remove from stash)
alias gstall='git stash --all' # push all changes (also untracked and ignored)
alias gstc='git stash clear' # clear stash stack
alias gstd='git stash drop' # remove given/last stashed object
alias gstl='git stash list' # print stash
alias gsts='git stash show --patch' # show diff between stash and working tree

alias gsi='git submodule init' # init
alias gsu='git submodule update'
alias gsuri='git submodule update --recursive --init'

alias gsw='git switch' # switch to given branch
alias gswc='git switch --create' # create branch and switch to it

alias gtv='git tag | sort -V' # 
alias gta='git tag --annotate' # crate annotated tag
alias gts='git tag --sign' # crate signed tag
alias gtl='gtl(){ git tag --sort=-v:refname -n --list "${1}*" }; noglob gtl' # function for list sorted tags with filtering

alias gwip='git add -A; git rm $(git ls-files --deleted) 2> /dev/null; git commit --no-verify --no-gpg-sign --message "--wip-- [skip ci]"' # work in progress commit
alias gunwip='git rev-list --max-count=1 --format="%s" HEAD | grep -q "\--wip--" && git reset HEAD~1' # undo work in progress commit

alias gwt='git worktree' # open two directories with same repo (same history, diffrent branches)
alias gwta='git worktree add' # add new worktree to existing local git repo
alias gwtls='git worktree list' # list all directories (worktrees) with opened branches and commits in them
alias gwtmv='git worktree move' # move worktree (and references in .git)
alias gwtrm='git worktree remove' # remove worktree (and references in .git)
