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
alias gclean='git clean --interactive -d' # interactive cleaning working dir from untracking files
alias gcount='git shortlog --summary --numbered' # displays list of people working for this repo

alias gd='git diff' # files modified in working directory (before git add)
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
alias glgg='git log --graph' # graph of commits with full info
gwch='git log --patch --abbrev-commit --pretty=medium --raw' #// TODO ???????????????????????????????????????????????????????????????????????????????????????????????

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

alias grh='git reset' # return files from staging area to working dir
alias gru='git reset --' # for defined files, move them from staging area to working dir
alias grhs='git reset --soft' # remove everything to defined commit and move it's changes to working dir (leaves staging area unchanged) // TODO do sprawdzenia ??????????????????????????
alias grhk='git reset --keep' # remove everything to defined commit, but try to keep local changes (abort if not possible)
alias grhh='git reset --hard' # remove everything from HEAD to defined commit (removes also changes in working dir and staging area)

alias gr='git remote'
alias gra='git remote add' # add new remote repo (gra origin <url>)
alias grmv='git remote rename' # change remote repo name
alias grrm='git remote remove' # remove remote repo address
alias grup='git remote update' # update info of each remote repo
alias grv='git remote --verbose' # print list of remote repos with full addresses
alias grset='git remote set-url' # change remote repo address

alias grb='git rebase'
alias grbi='git rebase --interactive' # interactive rebase provide possibility to squash(join), reorder, edit message or delete commits
alias grbo='git rebase --onto' # provide option to copy commits from other branch on new base                         //todo??????????????????????????
alias grba='git rebase --abort' # stop rebase and return to state before rebase
alias grbc='git rebase --continue' # continue rebase after conflicts solved and added
alias grbs='git rebase --skip' # skip commit which has unsolvable conflict while rebase

alias grev='git revert' # create commit with undo changes in defined commit
alias greva='git revert --abort' # abort reverting
alias grevc='git revert --continue' # continue revert after conflicts solved and added

grf='git reflog'

grm='git rm'
grmc='git rm --cached'

grs='git restore'
grss='git restore --source'
grst='git restore --staged'

gsh='git show'
gshs='git show --stat'
gsps='git show --pretty=short --show-signature'

gsd='git svn dcommit'
gsr='git svn rebase'

gsnut='git status --untracked-files=no'
gsb='git status --short --branch'
gss='git status --short'
gst='git status'

gsta='git stash push'
gstaa='git stash apply'
gstall='git stash --all'
gstc='git stash clear'
gstd='git stash drop'
gstl='git stash list'
gstp='git stash pop'
gsts='git stash show --patch'

gsi='git submodule init'
gsu='git submodule update'
gsuri='git submodule update --recursive --init'

gsw='git switch'
gswc='git switch --create'

gta='git tag --annotate'
gtl='gtl(){ git tag --sort=-v:refname -n --list "${1}*" }; noglob gtl'
gts='git tag --sign'
gtv='git tag | sort -V'
gunignore='git update-index --no-assume-unchanged'
gunwip='git rev-list --max-count=1 --format="%s" HEAD | grep -q "\--wip--" && git reset HEAD~1'
gwip='git add -A; git rm $(git ls-files --deleted) 2> /dev/null; git commit --no-verify --no-gpg-sign --message "--wip-- [skip ci]"'
gwipe='git reset --hard && git clean --force -df'

gwt='git worktree'
gwta='git worktree add'
gwtls='git worktree list'
gwtmv='git worktree move'
gwtrm='git worktree remove'
