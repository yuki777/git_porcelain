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

test "uu-1"
  "1U" = (touch a;and git_porcelain -C)
end

test "uu-2"
  "2U" = (touch a b;and git_porcelain -C)
end
