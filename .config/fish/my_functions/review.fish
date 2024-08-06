function review
  set pr_num $argv[1]
  echo $pr_num
  git fetch upstream pull/$pr_num/head:pull/$pr_num
  git switch pull/$pr_num
end