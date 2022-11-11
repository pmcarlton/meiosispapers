use strict;
$|=1;   #set autoflush
use utf8; 
binmode STDIN, ":utf8"; #needed for Unicode
binmode STDOUT, ":utf8"; #needed for Unicode

#preprocess the input stream first
#my $w=chr(0xc2).chr(0xa0); #this is a weird space character that you get sometimes in pubmed!
my $tlen=185; #how many characters of title to print out
while(<STDIN>) {
my $prg=0;
#s/($w)/ /; #replace the weird space with a real space
$prg=2 if(/meiosis/i || /synaptonemal/i || /meiot/i || /crossover/i); 
my @a=split("__",$_); #feedstail separated each field with "__", now we'll process each field at a time
my @tt=split(" ",$a[0]);
#my $t=join(" ",splice(@tt,2));
my $t=$a[0];
$a[1]=~s/\.//g;
my @auths=split(",",$a[1]);

$a[1]=$auths[0].$auths[1]; #attempting to make first author, 20200704pmc
#$a[1]=$auths[$#auths-1].$auths[$#auths]; last author

$a[2]=~s/.rss=1//;
my $rb=$a[1]." ".$a[2];
my $tl=length($rb);
if(length($t)>(230-$tl)){
    $t=substr($t,0,233-$tl);
    $t=~s/ $//;
    $t=$t."…";
    }
my $out=$t." |".$rb."\n";
$out=~s/(\W)…/$1/;#chomp($out);
my $cmd="";
if($prg==2) {print $out;}
#sleep(90);
}

#nohup feedstail -i 21600 -e -r -u "http://connect.biorxiv.org/biorxiv_xml.php?subject=all" -f {title}__{author}__{link}__{summary} | perl /home/pcarlton/code/pubmed-rss-twitter/biorxiv-filter.pl &
