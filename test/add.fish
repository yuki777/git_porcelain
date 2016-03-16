set path $DIRNAME/$TESTNAME

function setup
  mkdir -p $path
  pushd $path
  git init . > /dev/null
end

function teardown
  popd
  rm -rf $path
end

test "sa-1"
  "1A" = (touch a; and git add a; and git_porcelain -C)
end

test "sa-2"
  "2A" = (touch a b; and git add a b;and git_porcelain -C)
end
