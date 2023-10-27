#!/usr/bin/env bash

# https://medium.com/@nocnoc/combined-code-coverage-for-flutter-and-dart-237b9563ecf8
# ./test.sh --path /path/to/tests

# remember some failed commands and report on exit
error=false

show_help() {
    printf "usage: $0 [--help] [--path <path>]
Tool for running all unit and widget tests with code coverage and automatically generated if lcov is installed.

(run from root of repo)
where:
    --help
        print this message
    --path <path>
        run tests only in the specified path
"
    exit 1
}

# run unit and widget tests
runTests () {
  cd $1;
  if [ -f "pubspec.yaml" ] && [ -d "test" ]; then
    echo "running tests in $1"
    flutter pub get

    escapedPath="$(echo $1 | sed 's/\//\\\//g')"

    # run tests with coverage
    if grep flutter pubspec.yaml > /dev/null; then
      echo "run flutter tests"
      if [ -f "test/all_tests.dart" ]; then
        flutter test --coverage test/all_tests.dart || error=true
      else
        flutter test --coverage || error=true
      fi
      if [ -d "coverage" ]; then
        # combine line coverage info from package tests to a common file
        sed "s/^SF:lib/SF:$escapedPath\/lib/g" coverage/lcov.info >> $2/coverage/lcov.info
      fi
    else
      echo "not a flutter package, skipping"
    fi
  fi
  cd - > /dev/null
}

# parse command line arguments
while [[ $# -gt 0 ]]
do
    key="$1"

    case $key in
        --help)
            show_help
            ;;
        --path)
            path="$2"
            shift
            ;;
        *)
            # unknown option
            ;;
    esac
    shift
done

# run tests
if [ -n "$path" ]; then
    runTests "$path" "$(pwd)"
else
    for dir in $(find . -type d -name "test"); do
        runTests "$(dirname $dir)" "$(pwd)"
    done
fi

runReport() {
    if [ -f "coverage/lcov.info" ] && ! [ "$TRAVIS" ]; then
        genhtml coverage/lcov.info -o coverage --no-function-coverage -s -p `pwd`/coverage
        
		if $IsWindows || $ENV:OS; then
			start coverage/index.html
		else
			open coverage/index.html
		fi
    fi
}

if ! [ -d .git ]; then printf "\nError: not in root of repo"; show_help; fi

case $1 in
    --help)
        show_help
        ;;
    *)
        currentDir=`pwd`
        # if no parameter passed
        if [ -z $1 ]; then
            rm -f coverage/lcov.info
            dirs=(`find . -maxdepth 2 -type d`)
            for dir in "${dirs[@]}"; do
                runTests $dir $currentDir
            done
        else
            if [[ -d "$1" ]]; then
                runTests $1 $currentDir
            else
                printf "\nError: not a directory: $1"
                show_help
            fi
        fi
        runReport
        ;;
esac

# Fail the build if there was an error
if [ "$error" = true ] ;
then
    exit -1
fi
