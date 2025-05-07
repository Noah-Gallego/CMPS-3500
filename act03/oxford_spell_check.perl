#!/usr/bin/perl

# CMPS 3500
# oxford_spell_check.perl
use strict;
use warnings;

# Usage:  oxford_spell_check.perl [-h] [-f <filename>] 

# demonstrate file i/o and parsing cmdline args

# purpose: spell check an input file or spell check a single word
# 1. parse cmdline args - exit if nothing passed
# 1. open dictionary file 'dictionary' and read it into a hash table
# 2. open input file - loop through each line (1 word per line)
# 3. look up each word in the dictionary - display word if not found 
#
my $dictname = 'Oxford_English_Dictionary.txt';               # a dictionary file 
my $inf;                                   # input file handle
my $dict;                                  # dictionary file handle
my $filename = '';
my $a_word;

# open dictionary file and read each word into a local hash table (a map)
open($dict, '<', $dictname) or die "Can't read dictionary: $!";    
my $word;
my %wordMap;       
                       
# 'while' reads one line at a time into $_
while(<$dict>) {                     
  chomp;                           
  next if /^$/;                    # Skip empty lines
  $word = lc($_);                   # Convert to lowercase
  $word =~ s/^\s+|\s+$//g;           # Trim spaces at start and end
  $word =~ s/[^a-zA-Z0-9'-]//g;      # Keep only letters, numbers, apostrophes, and hyphens
  $wordMap{$word} = 1;               # Store cleaned word
}
close($dict);

# here we simmply look up a single word from the command line
# =~ associates string with regex match 
if (@ARGV eq 0) {                       # ARGV is command line arg array 
   print "Enter a word: ";              # prompt the user 
   $a_word = <stdin>;                   # read from stdin
   chomp($a_word);                      # remove trailing stuff
   $a_word =~ tr/A-Z/a-z/;              # translates upper char to lower char 
   if ( ! $wordMap{$a_word} ) { 
      print "misspelled word: ", $a_word, "\n";
   }
   else {
      print "spelling OK \n";
   }
   exit;
}

# if we made it here we need to parse the command line args
##########################
# PARSE CMDLINE ARGS
##########################
while (@ARGV) {                         # parse command line arguments 
  if ($ARGV[0] eq '-f') {
    shift;                              # move array elements up 
    $filename = $ARGV[0];
    shift;
    next;                               # jump to start of while loop 
  }
  elsif ( $ARGV[0] eq '-h') {           # display usage 
     print "\nUsage: oxford_spell_check.perl [-h] [-f <filename>]\n\n";
     shift;
     if (!@ARGV) {
        exit;
     }
     else {
       next; }
  } 
  else {   
     shift;                             # unknown argument so skip it
     next;
  }
}

# now open the input file for spellchecking 
open($inf, '<', $filename) or die "Can't read input file: $!";    

# Define some variables
my $count_misspelled = 0;
my @words;
my $line;

while(<$inf>) 
{
   chomp;                        # remove CR LF from $_
   $line = $_;
   $line =~ s/ +/ /g;            # remove extra spaces
   @words = split /\s/,$line;    # split by whitespace - space,TAB,CR,LF
   foreach (@words) {
      $word = lc($_);
      $word =~ s/^\s+|\s+$//g;           # Trim spaces at start and end
      $word =~ s/[^a-zA-Z0-9'-]//g;      # Remove unwanted characters
      if ( !exists $wordMap{$word} ) { 
         $count_misspelled++;
         print "misspelled word $count_misspelled: $word\n";
      }
   }
}     
close($inf);

print $count_misspelled
