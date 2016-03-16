function git_porcelain
  set -g p_path (dirname (status -f))
  set -l STAGED (set_color green)
  set -l UNSTAGED (set_color red)
  set -l UNTRACKED (set_color -o black)
  set -l NORMAL (set_color normal)

  git status --porcelain 2> /dev/null | awk -f $p_path/git_porce.awk | read -a vars
  set LETTERS "A" "M" "D" "R" "C" "M" "D" "U"
  
  echo -n -s $NORMAL
  for i in (seq 5)
    if test ! $vars[$i] -eq 0
      echo -n -s $vars[$i] $STAGED $LETTERS[$i] $NORMAL
    end
  end
  if test ! $vars[6] -eq 0 -a $vars[7] -eq 0
    echo -n -s " "    
  end
  for i in (seq 6 7)
    if test ! $vars[$i] -eq 0
      echo -n -s $vars[$i] $UNSTAGED $LETTERS[$i] $NORMAL
    end
  end
  if test ! $vars[8] -eq 0
    echo -n -s " " $vars[8] $UNTRACKED "U" $NORMAL
  end
end
