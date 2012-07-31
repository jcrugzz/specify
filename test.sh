node test/specify.js | sed 's/.\[[0-9][0-9]m//g' | sed 's/"at.*\(.*\)//' \
  > test/all.log
node test/specify.js specify#throws specify#cascading_sync \
  | sed 's/.\[[0-9][0-9]m//g' | sed 's/"at.*\(.*\)//' >  test/filters.log
node test/specify/singletest.js | sed 's/.\[[0-9][0-9]m//g' > test/single.log
node bin/specify -e SPECIFY_REPORTER=compact > test/reporter.log
node bin/specify -r compact > test/reporter2.log
diff test/all.log test/fixtures/all.txt
if [ $? -eq 0 ]; then
  diff test/filters.log test/fixtures/filters.txt
  if [ $? -eq 0 ]; then
    diff test/single.log test/fixtures/single.txt
    if [ $? -eq 0 ]; then
      diff test/reporter.log test/fixtures/reporter.txt
      if [ $? -eq 0 ]; then
        diff test/reporter.log test/reporter2.log
        if [ $? -eq 0 ]; then
          echo "ok";
        else
          exit 1;
        fi
      else
        exit 1;
      fi
    else
      exit 1;
    fi
  else
    exit 1;
  fi
else
  exit 1;
fi