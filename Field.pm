package Field;

use Moo;
use namespace::autoclean;

with 'Constraint';


has name => (
    is => 'rw',
    #isa => sub { die "You should put the value of Field->name here." unless $_[0] }
	);
	
has type => (
    is => 'rw',
	#isa => sub {die "attribute Field->type get wrong on initialing." unless ($_[0] eq 'INT' ||  $_[0] eq 'VARCHAR' ||  $_[0] eq 'DATE' ||  $_[0] eq 'DECIMAL') },
);

has len => (
    is => 'rw',
    isa => sub  {die "attribute Field->len get wrong on initialing." unless $_[0] =~/\d+/});

  


1;
