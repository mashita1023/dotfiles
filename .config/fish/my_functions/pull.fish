function pull
  git fetch --all -avp
  git stash
  git switch develop
  git pull upstream develop
  set merged_branch (git branch --merged | egrep -v '\*|develop|main')
  echo $merged_branch | xargs git branch -d
  git switch -
  echo "delete branch list: $merged_branch"
end
