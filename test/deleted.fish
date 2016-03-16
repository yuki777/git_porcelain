set path $DIRNAME/$TESTNAME

function setup
  mkdir -p $path
  pushd $path
  git init . > /dev/null
  touch a b c
  git add a b c
  git config user.email "foo@bar.com"
  git config user.name "foobar"
  git commit -m "Added a b c" > /dev/null
end

function teardown
  popd
  rm -rf $path
end

test "sd-1"
  "1D" = (rm c;git add -A;and git_porcelain -C)
end

test "sd-2"
  "2D" = (rm b c;git add -A;and git_porcelain -C)
end

test "ud-1"
  "1D" = (rm c;and git_porcelain -C)
end

test "ud-2"
  "2D" = (rm b c;and git_porcelain -C)
end

test "sd-1 ud-2"
  "1D 2D" = (rm a b c; git add a;and git_porcelain -C)
end

test "sd-2 ud-2"
  "2D 1D" = (rm a b c; git add a b;and git_porcelain -C)
end
