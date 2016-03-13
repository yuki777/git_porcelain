function git_porcelain
  set -g p_path (dirname (status -f))
  set -l STAGED (set_color green)
  set -l UNSTAGED (set_color red)
  set -l UNTRACKED (set_color -o black)
  set -l NORMAL (set_color normal)

  git status --porcelain 2> /dev/null | awk -f $p_path/git_porce.awk | read -a vars
  echo -n -s $NORMAL
  if test ! $vars[1] -eq 0
    echo -n -s $vars[1] $STAGED "A" $NORMAL
  end
  if test ! $vars[2] -eq 0
    echo -n -s $vars[2] $STAGED "M" $NORMAL
  end
  if test ! $vars[3] -eq 0
    echo -n -s $vars[3] $STAGED "D" $NORMAL
  end
  if test ! $vars[4] -eq 0
    echo -n -s $vars[4] $STAGED "R" $NORMAL
  end
  if test ! $vars[5] -eq 0
    echo -n -s $vars[5] $STAGED "C" $NORMAL 
  end
  if test ! $vars[6] -eq 0 -a $vars[7] -eq 0
    echo -n -s " "
    if test ! $vars[6] -eq 0
      echo -n -s $vars[6] $UNSTAGED "M" $NORMAL
    end
    if test ! $vars[7] -eq 0
      echo -n -s $vars[7] $UNSTAGED "D" $NORMAL
    end
  end
  if test ! $vars[8] -eq 0
    echo -n -s " " $vars[8] $UNTRACKED "U" $NORMAL
  end
end
