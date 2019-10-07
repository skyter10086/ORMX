package TabDemo;
use DBObject;
use Schema; 

use Moo;
use namespace::autoclean;

my $db = DBObject->new(
        source=>"dbi:SQLite:dbname=test.db",
        user=>"",
        auth=>"",
        options=>{sqlite_unicode => 1,RaiseError => 1, AutoCommit => 1},);
my $schema = Schema->new(
        name => 'company',
        fields => [
            Field->new(name=>'name',type=>'VARCHAR',len=>60,primary=>1),
            Field->new(name=>'property',type=>'NUM',len=>12,default=>0.0,not_null=>1),
            Field->new(name=>'people',type=>'NUM',len=>10,not_null=>1),
        ],);
        
has db => (
    is => 'ro',
    handles => 'DBO',
    default => sub { $db},
);

has scm => (
    is => 'ro',
    does => 'Schem',
    handles => {schema => 'build',
		        primary => 'pk'},
    default => sub {$schema},
    );



1;
