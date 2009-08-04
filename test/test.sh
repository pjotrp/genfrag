#! /bin/sh

ruby=/home/wrk/.nix-profile/bin/ruby
$ruby ../bin/genfrag index -f example.fasta --RE5 BstYI --RE3 MseI --tracktime
$ruby ../bin/genfrag search -f example.fasta --RE5 BstYI --RE3 MseI --adapter3 aacc --adapter5 tt --tracktime
