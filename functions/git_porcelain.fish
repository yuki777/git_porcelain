function git_porcelain
  set -l staged (set_color green)
  set -l unstaged (set_color red)
  set -l untracked (set_color -o black)
  set -l normal (set_color normal)
  set -l opts ""
  set -l empty 1

  if set -q argv[1]
    switch "$argv[1]"
      case "-C" "--no-color"
        set opts "no-color"
      case \*
        printf "%s is not a valid option." "$argv[1]"
        return 1
    end
  end

  git status --porcelain 2> /dev/null | awk '

  BEGIN {
    sa=0;
    sm=0;
    sd=0;
    sr=0;
    sc=0;
    um=0;
    ud=0;
    uu=0;
    }

    /^A[MCDR ]/     {  sa++ }
    /^M[ACDRM ]/    {  sm++ }
    /^D[AMCR ]/     {  sd++ }
    /^R[AMCD ]/     {  sr++ }
    /^C[AMDR ]/     {  sc++ }
    /^[ACDRM ]M/    {  um++ }
    /^[AMCR ]D/     {  ud++ }
    /^\?\?/         {  uu++ }

  END {
  printf("%d %d %d %d %d %d %d %d", sa, sm, sd, sr, sc, um, ud, uu)
  }

  ' | read -a vars

  set legend "A" "M" "D" "R" "C" "M" "D" "U"

  if not contains -- no-color $opts
    echo -n -s $normal
  end

  for i in (seq 5)
    if test ! $vars[$i] -eq 0
      set empty 0
      if contains -- no-color $opts
        echo -n -s $vars[$i] $legend[$i]
      else
        echo -n -s $vars[$i] $staged $legend[$i] $normal
      end
    end
  end

  if test $vars[6] -gt 0 -o $vars[7] -gt 0
    if test 0 -eq $empty
      echo -n -s " "
    end
  end

  for i in (seq 6 7)
    if test ! $vars[$i] -eq 0
      set empty 0
      if contains -- no-color $opts
        echo -n -s $vars[$i] $legend[$i]
      else
        echo -n -s $vars[$i] $unstaged $legend[$i] $normal
      end
    end
  end

  if test ! $vars[8] -eq 0
    if test 0 -eq $empty
      echo -n -s " "
    end
    if contains -- no-color $opts
      echo -n -s $vars[8] "U"
    else
      echo -n -s $vars[8] $untracked "U" $normal
    end
  end

  # Stash
  set -l stash_count (git stash list 2>/dev/null | wc -l | tr -d ' ')
  if test ! $stash_count -eq 0
    echo -n -s " {$stash_count}"
  end

  # Current hash
  set -l current_hash (git rev-parse HEAD 2>/dev/null|cut -c-7)
  echo -n -s " $current_hash"

  # Branch (e.g. origin/master)
  set -l symbolic_ref (git symbolic-ref -q HEAD 2>/dev/null)
  set -l tracking_branch (git for-each-ref --format='%(upstream:short)' "$symbolic_ref" 2> /dev/null)

  # Ahead and Behind
  set -l ahead_count  (git rev-list --right-only --count "$tracking_branch"...HEAD 2>/dev/null)
  set -l behind_count (git rev-list --left-only  --count "$tracking_branch"...HEAD 2>/dev/null)
  if test ! $ahead_count -eq 0
    echo -n -s " $ahead_count=>"
  end
  if test ! $behind_count -eq 0
    echo -n -s " <=$behind_count"
  end
end
