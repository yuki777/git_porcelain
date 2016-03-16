set path $DIRNAME/$TESTNAME

function setup
  mkdir -p $path
  pushd $path
  git init . > /dev/null
  touch a b c
  git add a b c
  git config user.email "foo@bar.com"
  git config user.name "foobar"
  git commit -m "Added a" > /dev/null
end

function teardown
  popd
  rm -rf $path
end

test "sr-1"
  "1R" = (mv a d; git add -A; git_porcelain -C)
end

test "sr-2"
  "2R" = (mv a d; mv b e; git add -A; git_porcelain -C)
end
