function git_porcelain
    set -l staged (set_color green)
    set -l unstaged (set_color red)
    set -l untracked (set_color -o black)
    set -l normal (set_color normal)

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

    echo -n -s $normal

    for i in (seq 5)
        if test ! $vars[$i] -eq 0
            echo -n -s $vars[$i] $staged $legend[$i] $normal
        end
    end

    if test ! $vars[6] -eq 0 -a $vars[7] -eq 0
        echo -n -s " "
    end

    for i in (seq 6 7)
        if test ! $vars[$i] -eq 0
            echo -n -s $vars[$i] $unstaged $legend[$i] $normal
        end
    end

    if test ! $vars[8] -eq 0
        echo -n -s " " $vars[8] $untracked "U" $normal
    end
end
