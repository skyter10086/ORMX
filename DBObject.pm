package DBObject;

use Moo;
use namespace::autoclean;
use DBD::SQLite;
use DBIx::Lite;

#use DBIx::Lite;
with 'DBO';

has source => (
    is => 'rw',
    isa => sub {
        die "The source should be correct!" unless $_[0] =~ m/^dbi:(Pg|SQLite|mysql|CSV):dbname\=.*/;
    },
);

has user => (
    is => 'rw',
    
);

has auth => (
    is => 'rw',
    
);

has options => (
    is => 'rw',
    isa => sub {
        die "" unless ref $_[0] eq 'HASH';
    },
);

sub connect {
    my $self = shift;
    my $dbx = DBIx::Lite->new(dbh=>$self->dbh);
    #my $dbh = DBI->connect($self->source, $self->user, $self->auth, $self->options);
    #my $dbx = DBIx::Lite->new(dbh=>$dbh);
    $dbx->connect($self->source, $self->user, $self->auth, $self->options);
}

sub dbh {
    my $self =shift;
    my $dbh = DBI->connect($self->source, $self->user, $self->auth, $self->options);
    	
}











1;
