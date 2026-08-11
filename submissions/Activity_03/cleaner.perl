#!/usr/bin/perl
#############################################
## NAME: Noah Gallego                      ##
## ORGN: CSUB - CMPS 3500                  ##
## FILE: cleaner .perl                     ##
## DATE: 02/28/25                          ##
#############################################

use strict;
use warnings;

open my $fh, '<', 'Asimov-Isaac-I-Robot.txt' or die qq{Unable to open input file: $!};

while (<$fh>) {
    my @tokens = split /\s+/;      # split line on whitespace into words/tokens
    for my $token (@tokens) {
        # Remove non-alphanumeric at start
        $token =~ s/^[^a-zA-Z0-9]+//g;  
        # Remove non-alphanumeric at end
        $token =~ s/[^a-zA-Z0-9]+$//g;

        # print Each cleaned token on a new line (LowerCase)
        print lc($token), "\n";
    }
}
