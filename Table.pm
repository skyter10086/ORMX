package Table;

use Moo::Role;
use namespace::autoclean;
use DBObject;
#use Field;
use Schema;
use Data::Printer;

requires 'db','schema';

#with 'Schema';
=pod
my $db;
my $schema;

sub set_db {
    my ($db_param) = @_;
	$db = DBObject->new(%$db_param) 
	      or die "Call X::TypeException on class of DBObject";
}

sub db {
    my $self = shift;
    return $db;	
	
}

sub set_schema {
    #my $self = shift;
    $schema = shift;	
    print "in set_schema...","\n";
    p $schema->name;
    
}

sub schema { 
	my ($self) =@_;
	return $schema; 
}

sub add_field {
	$schema->add_field(@_);
	
	}
=cut
sub _init {
    my ($class) = @_;
    my $sql = $class->schema->build;
    my $dbh = $class->db->dbh;
    $dbh->do($sql) ;
    
	
}

# CRUDs
sub insert {
    my $self = shift;
    my $fields_hr = shift;
    my $dbx = $self->db->dbx;
    my $table = $self->schema->name;
    my $res = $dbx->table($table)->insert($fields_hr);
    #p $res;
    #return $res;
    return 1;
    
    	
}

sub update {
	my $self = shift;
	my $filter_hr = shift;
	my $alter_hr = shift;
	my $dbx = $self->db->dbx;
    my $table = $self->schema->name;
    my $result;
    if ($filter_hr) {
        $result = $dbx->table($table)->search($filter_hr)->update($alter_hr);
    } else {
	    $result = $dbx->table($table)->update($alter_hr);
	}
	#p $result;
	return $result;
}

sub select {
	my $self = shift;
	my $selected_fields_ar = shift;
	my $filter_hr = shift;
	my $dbx = $self->db->dbx;
    my $table = $self->schema->name;
    return my $result = $dbx->table($table)
                         ->select(@$selected_fields_ar)
                         ->search($filter_hr) if $filter_hr;
    return my $res = $dbx->table($table)
                         ->select(@$selected_fields_ar)
                         unless $filter_hr;
                     
}

sub delete {
	my $self = shift;
	my $filter_hr = shift;
	my $dbx = $self->db->dbx;
    my $table = $self->shcema->name;
    my $result;
    if ($filter_hr) {
        $result = $dbx->table($table)->search($filter_hr)->delete;
    } else {
	    $result = $dbx->table($table)->delete;
	}
	#p $result;
	return $result;

}

sub log_print {
    my $called = shift;
    my $params = shift;
    my $res = &$called(@$params);
    printf "Calling %s with %s", $called, @$params;
    	
}














1;
