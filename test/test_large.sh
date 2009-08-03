#! /bin/sh

genfrag=/home/wrk/izip/git/opensource/genfrag/bin/genfrag
fn=large.fasta
$genfrag index $* -f $fn --RE5 BstYI --RE3 MseI --tracktime > test_index.log
$genfrag search $* -f $fn --RE5 BstYI --RE3 MseI --adapter3 aa --adapter5 tt --tracktime > test_search.log
