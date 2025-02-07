function pull
  git fetch --all -avp
  git stash

  if test -z (git branch | grep main)
    set default develop
  else
    set default main
  end
  
  git switch $default
  git pull origin $default
  set merged_branch (git branch --merged | egrep -v '\*|develop|main')
  echo $merged_branch | xargs git branch -d
  git switch -
  echo "delete branch list: $merged_branch"
end
