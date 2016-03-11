function git_porcelain -d "Return short git status"
  set -l gitstatus
  git status --porcelain 2> /dev/null | pipeset gitstatus
  set -l STAGED (set_color green)
  set -l UNSTAGED (set_color red)
  set -l UNTRACKED (set_color -o black)
  set -l NORMAL (set_color normal)

  if git_is_repo
    set -l output $NORMAL
    set -l added_s (printf '%s' "$gitstatus" | grep -oE 'A[MCDR ] ' | wc -l | grep -oEi '[1-9][0-9]*')
    set -l modified_s (printf '%s' "$gitstatus" | grep -oE 'M[ACDRM ] ' | wc -l | grep -oEi '[1-9][0-9]*')
    set -l deleted_s (printf '%s' "$gitstatus" | grep -oE 'D[AMCR ] ' | wc -l | grep -oEi '[1-9][0-9]*')
    set -l renamed_s (printf '%s' "$gitstatus" | grep -oE 'R[AMCD ] ' | wc -l | grep -oEi '[1-9][0-9]*')
    set -l copied_s (printf '%s' "$gitstatus" | grep -oE 'C[AMDR ] ' | wc -l | grep -oEi '[1-9][0-9]*')
    
    set -l modified_u (printf '%s' "$gitstatus" | grep -oE '[ACDRM ]M ' | wc -l | grep -oEi '[1-9][0-9]*') 
    set -l deleted_u (printf '%s' "$gitstatus" | grep -oE '[AMCR ]D ' |wc -l| grep -oEi '[1-9][0-9]*')

    set -l untracked (printf '%s' "$gitstatus" | grep -oE "\?\? " | wc -l | grep -oEi '[1-9][0-9]*') 

    if test ! -z "$added_s"
      set output $output (echo -n -s "$added_s" $STAGED "A" $NORMAL)
    end
    
    if test ! -z "$modified_s"
      set output $output (echo -n -s "$modified_s" $STAGED "M" $NORMAL)
    end
    
    if test ! -z "$deleted_s"
      set output $output (echo -n -s "$deleted_s" $STAGED "D" $NORMAL)
    end

    if test ! -z "$renamed_s"
      set output $output (echo -n -s "$renamed_s" $STAGED "R" $NORMAL)
    end

    if test ! -z "$copied_s"
      set output $output (echo -n -s "$copied_s" $STAGED "C" $NORMAL)
    end

    set output $output " "
    
    if test ! -z "$modified_u"
      set output $output (echo -n -s "$modified_u" $UNSTAGED "M" $NORMAL)      
    end
    
    if test ! -z "$deleted_u"
      set output $output (echo -n -s "$deleted_u" $UNSTAGED "D" $NORMAL)
    end
    
    set output $output " "
    
    if test ! -z "$untracked"
      set output $output (echo -n -s $untracked $UNTRACKED "U" $NORMAL)
    end
    
    echo -n -s $output
  end
end
