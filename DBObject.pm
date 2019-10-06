package DBObject;

use Moo;
use namespace::autoclean;

use DBIx::Lite;

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

sub dbh {
    my $self = shift;
    my $dbh = DBI->connect($self->source, $self->user, $self->auth, $self->options);
}

sub dbx {
    my $self = shift;
    if ( $self->dbh ) {
        my $dbx = DBIx::Lite->new(dbh => $self->dbh);
    } else {
        return;
    }
}










1;