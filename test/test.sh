#! /bin/sh

../bin/genfrag index -f example.fasta --RE5 BstYI --RE3 MseI --tracktime
../bin/genfrag search -f example.fasta --RE5 BstYI --RE3 MseI --adapter3 aacc --adapter5 tt --tracktime
