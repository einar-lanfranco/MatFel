use Socket;
my $iaddr = inet_aton("192.168.56.1"); # or whatever address

my $name = gethostbyaddr($iaddr, AF_INET);
print $name;
my $iaddr = inet_aton("163.10.5.66"); # or whatever address

my $name = gethostbyaddr($iaddr, AF_INET);
print $name;
