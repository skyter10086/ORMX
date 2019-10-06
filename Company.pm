package Company;

use Moo;
use namespace::autoclean;
use MyTable;

with 'Model';





has name => (
    is => 'rw',
    
);

has property => (
    is => 'rw',
    );

has count => (
    is => 'rw',
);

sub map {
	my $map = {
	    'name' => 'name',
	    'property' => 'property',
	    'count' => 'people',	
	};

}

sub table {
   my $table =  MyTable->new;	
}







1;
