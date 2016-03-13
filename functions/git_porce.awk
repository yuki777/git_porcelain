BEGIN {
    sa=0;
    sm=0;
    sd=0;
    sr=0;
    sc=0;
    um=0;
    ud=0;
    u=0;
}
{
    if ($0 ~ /^A[MCDR ]/) sa++;
    if ($0 ~ /^M[ACDRM ]/) sm++;
    if ($0 ~ /^D[AMCR ]/) sd++;
    if ($0 ~ /^R[AMCD ]/) sr++;
    if ($0 ~ /^C[AMDR ]/) sc++;
    if ($0 ~ /^[ACDRM ]M/) um++;
    if ($0 ~ /^[AMCR ]D/) ud++;
    if ($0 ~ /^\?\?/) u++;
}
END {
    printf "%d %d %d %d %d %d %d %d", sa, sm, sd, sr, sc, um, ud, u;
}
