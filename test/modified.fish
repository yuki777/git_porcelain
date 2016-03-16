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

test "sm-1"
  "1M" = (echo a > a; and git add a; and git_porcelain -C)
end

test "sm-2"
  "2M" = (echo a > a; echo b > b; and git add a b;and git_porcelain -C)
end

test "um-1"
  "1M" = (echo a > a; and git_porcelain -C)
end

test "um-2"
  "2M" = (echo a > a; echo b > b;and git_porcelain -C)
end

test "sm-1 um-2"
  "1M 2M" = (echo a > a; echo b > b; echo c > c;and git add a;and git_porcelain -C)
end

test "sm-2 um-1"
  "2M 1M" = (echo a > a; echo b > b; echo c > c;and git add a b;and git_porcelain -C)
end
