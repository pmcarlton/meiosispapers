use strict;
$|=1;   #set autoflush
use utf8; 
binmode STDIN, ":utf8"; #needed for Unicode
binmode STDOUT, ":utf8"; #needed for Unicode

#preprocess the input stream first
#my $w=chr(0xc2).chr(0xa0); #this is a weird space character that you get sometimes in pubmed!
my $tlen=185; #how many characters of title to print out
while(<STDIN>) {
#s/($w)/ /; #replace the weird space with a real space
s/PLoS/PLOS/; #all-uppercase now

my @a=split("__",$_); #feedstail separated each field with "__", now we'll process each field at a time
my $b=substr($a[0],0,$tlen); #the title field: accept up to $tlen characters
   $b =~ s/\W*$//; #get rid of trailing spaces, commas, etc
my $v=" | "; $v="…|" if (length($a[0])>($tlen)); #if title is truncated, add ellipsis before |
#my $c=$a[1];$c=~s/^.*u\'//;$c=~s/\'.*//;$c.="•";  # get the journal name, for those who care
#cannot get it since tags field no longer exported?!
my $d=$a[1];#$d=~s/^.*, //; $d.='  '; # get last^H^H^H^Hfirst author (now default in PubMed)
$d.=' | ';
#my $d=$a[1];$d=~s/^.*, //; $d.='  '; # get last^H^H^H^Hfirst author (now default in PubMed)
my $e=$a[2];$e=~s/^.*\/(\d\d\d\d\d\d\d\d)\/.*/https:\/\/pubmed\.gov\/$1/;  # Debiggen the link, no URL shorteners

my $line=$b.$v.$d.$e; #add parts all together on one line…but we're not done yet:
#my $line=$b.$v.$c.$d.$e; #add parts all together on one line…but we're not done yet:

#check for 280-char limit:
while (length($line)>268) { #just paranoid about edge cases clipping the pubmed URL
    $b=substr($b,0,length($b)-1); #take off the last character of the title if the line's too long
    $b=~s/\W*$//; #take off trailing non-letter characters again
    $line=$b.$v.$d.$e; #reassemble the line and check it again
    #$line=$b.$v.$c.$d.$e; #reassemble the line and check it again
    }
print $line; #this is what gets sent to ttytter or your logfile, etc.
}
