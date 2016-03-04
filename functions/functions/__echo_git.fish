function __echo_git -a num letter color
  echo -n -s $num (set_color $color) $letter (set_color normal)
end
