#!/bin/bash
set -ex

RESULT=0

filename="test-reports/test_output"

dart pub get

dart test --file-reporter=json:$filename.json || RESULT=1

dart pub global run w_test_tools:xunit_parser -j "$filename.json" -t "$filename.xml"

rm "$filename.json"

exit $RESULT