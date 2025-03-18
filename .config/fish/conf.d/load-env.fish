function load_env
  for line in (cat ~/.config/env/.env)
    set -l parts (string split = $line)
    set -gx $parts[1] $parts[2]
  end
end

if test -f ~/.config/env/.env
  load_env
end
