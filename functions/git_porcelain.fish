function git_porcelain -d "Return short git status"
  set -l gitstatus (git status --porcelain 2> /dev/null | cut -c-3)

  if git_is_repo
    set -l output (set_color normal)
    set -l added_s (printf '%s' "$gitstatus" | grep -oE "A[MCDR ] " | wc -l | grep -oEi '[1-9][0-9]*')
    set -l modified_s (printf '%s' "$gitstatus" | grep -oE "M[ACDRM ] " | wc -l | grep -oEi '[1-9][0-9]*')
    set -l deleted_s (printf '%s' "$gitstatus" | grep -oE "D[AMCR ] " | wc -l | grep -oEi '[1-9][0-9]*')
    set -l renamed_s (printf '%s' "$gitstatus" | grep -oE "R[AMCD ] " | wc -l | grep -oEi '[1-9][0-9]*')
    set -l copied_s (printf '%s' "$gitstatus" | grep -oE "C[AMDR ] " | wc -l | grep -oEi '[1-9][0-9]*')
    
    set -l modified_u (printf '%s' "$gitstatus" | grep -oE "[ACDRM ]M " | wc -l | grep -oEi '[1-9][0-9]*') 
    set -l deleted_u (printf '%s' "$gitstatus" | grep -oE "[AMCR ]D " |wc -l| grep -oEi '[1-9][0-9]*')

    set -l untracked (printf '%s' "$gitstatus" | grep -oE "\?\? " | wc -l | grep -oEi '[1-9][0-9]*')    

    if not test -z $added_s
      set output $output (__echo_git $added_s "A" green)
    end
    
    if not test -z $modified_s
      set output $output (__echo_git $modified_s "M" green)
    end
    
    if not test -z $deleted_s
      set output $output (__echo_git $deleted_s "D" green)
    end

    if not test -z $renamed_s
      set output $output (__echo_git $renamed_s "R" green)
    end

    if not test -z $copied_s
      set output $output (__echo_git $copied_s "C" green)
    end

    set output $output " "
    
    if not test -z $modified_u
      set output $output (__echo_git $modified_u "M" red)      
    end
    
    if not test -z $deleted_u
      set output $output (__echo_git $deleted_u "D" red)
    end
    
    set output $output " "
    
    if not test -z $untracked
      debug $untracked
      set output $output (echo -n -s $untracked (set_color -o black) "U" (set_color normal))
    end
    
    echo -n -s $output
  end
end
