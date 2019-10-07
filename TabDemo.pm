package TabDemo;
use DBO;
use Schema;

use Moo;
use namespace::autoclean;

has db => (
    is => 'ro',
    handles => 'DBO',
);

has scm => (
    is => 'ro',
    does => 'Schem',
    handles => {schema => 'build',
		        primary => 'pk'},
    );



1;
