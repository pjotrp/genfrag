#! /bin/sh

genfrag=../bin/genfrag
fn=large.fasta
# ruby -rprofile $genfrag search $* -f $fn --RE5 BstYI --RE3 MseI --adapter3 aa --adapter5 tt --tracktime > test_search.log
$genfrag search $* -f $fn --RE5 BstYI --RE3 MseI --adapter3 aa --adapter5 tt --tracktime > test_search.log
