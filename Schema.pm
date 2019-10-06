package Schema v0.0.1;

use Moo; 
use namespace::autoclean;
use Field;

use Data::Printer;

my $pk;

has name => (
    is => 'ro',
);

has fields => (
    is => 'rw',
    isa => sub {
		    my @f = @_;
		    #p @f;
		    foreach my $f (@{$f[0]}) {
				#p $f;
				if ($f->primary) {
					$pk = $f->name;
					#p $pk;
				}
			    die "The Constraint of Field validating failed." unless ref $f eq 'Field';	
			}
		},
);

sub pk {return $pk;}
=pod
my @fields;
#my $constraint;
my $name;
my $fields_index_hr;
my $pk;




# Define schema

sub name {
    shift;
    my $name_param = shift;
    if ($name_param) {
	    $name = $name_param ;
    } else {
	    $name;
	} 
}


sub fields {
=pod	
    shift;
	my @arr = @_;
	while (@arr) {
	    foreach my $scalar (@arr) {
		    die "Call X::TypeException on class of Field" unless ref $scalar eq 'Field';
		}
		@fields = @arr;
	}

	\@fields;
}



sub pk {
    return $pk;	
}

sub fields_index {
    my $class = shift;
    my $fields_arr =  \@fields;
    my $fields_count = @$fields_arr;
    for (my $i = 0; $i < $fields_count; $i++) {
		my $field_tmp = $fields_arr->[$i];
		my $tmp_name = $field_tmp->name;
	    $fields_index_hr->{$tmp_name} = $i;
	    $pk = $tmp_name if $field_tmp->primary;
	    
	}
	return $fields_index_hr;	
}

sub add_field {
    my ($cls, $field_param) = @_;
	push @fields , Field->new(%$field_param);
	
	return 1;
}

sub del_field {
    my ($cls, $field_name) = @_;
    for( 0..$#fields) {
	    if ({$fields[$_]}->name eq  $field_name) {
		    splice @fields, $_, 1;
		} 
	}
	$cls->fields_index;
	return 1;
}

sub alter_field {
    my ($cls, $field) = @_;
	my $fn = $field->name;
	for( 0..$#fields) {
	    if ({$fields[$_]}->name eq  $fn) {
		    splice @fields, $_, 1, $field;
		} 
	}
	$cls->fields_index;
	return 1;
}


=pod
sub constraint {
        my ($cls,$scalar) = @_;
		die "Call X::TypeException on class of Constraint" unless ref $scalar eq 'Constraint';    
		    
	}
    $constraint;	
}



my $constraint_add_subs = {
    unique => sub {my $f = $_;  $constraint->{unique}->{$f} = 1 ;},
	index => sub {my ($f, $p) = @_; $constraint->{index}->{$f} = $p;},
	not_null => sub {my $f = $_;  $constraint->{not_null}->{$f} = 1 ;},
	default =>  sub {my ($f, $p) = @_;  $constraint->{default}->{$f} = $p;},
	primary =>  sub {my @f = @_; @$constraint->{primary} = @f;},

};

my $constraint_del_subs = {
    unique => sub {my $f = $_;  $constraint->{unique}->{$f} = undef ;},
	index => sub {my ($f) = @_; $constraint->{index}->{$f} = undef;},
	not_null => sub {my $f = $_;  $constraint->{not_null}->{$f} = undef ;},
	default =>  sub {my ($f) = @_;  $constraint->{default}->{$f} = undef;},
	primary =>  sub { @$constraint->{primary} = undef;},

};

sub add_constraint {
    my ($class, $type, $field_name, $param) = @_;
	$constraint_add_subs->{$type}->($field_name,$param); 
	
}

sub del_constraint {
    my ($class, $type, $field_name) = @_;
	$constraint_add_subs->{$type}->($field_name);
}


sub alter_constraint {
    my ($class, $type, $field_name, $param) = @_;
}
=cut


sub build {
    my $self = shift;
    my $name = $self->name;
    my $fields = $self->fields;
    p $fields;
	my $stmt = "CREATE TABLE $name \( \n";
	my @flds = @$fields;
	my $fields_count = $#flds;
	print "fields_count is : $fields_count \n";
	
	
	for (my $i=0; $i <= $fields_count; $i++) {
		
		my $fi = $fields->[$i];
		my $name = $fi->name;
		my $type = $fi->type;
		my $len = $fi->len;
		my $default  = $fi->default;
		my $unique = $fi->unique;
		#my $index = $fi->index;
		my $primary = $fi->primary;
		my $not_null = $fi->not_null;
		
		$stmt .= "  ";
		$stmt .= $fi->name . " ";
		$stmt .= "$type\($len\) ";
		$stmt .= " DEFAULT $default" if $default;
		$stmt .= " UNIQUE" if $unique;
		$stmt .= " NOT NULL" if $not_null;
		
		$stmt .= " PRIMARY KEY" if $primary;
		if ($i < $fields_count) {
		    $stmt .= ",\n";	
		} else {
			$stmt .= "\n\)";
		}
		#if ($primary) {
		 #   $stmt .= "PRIMARY KEY ";
		  #  $pri =1;
	    #}
		#print "ok of 1st\n";
		
		#$i++;
		
		
	}
	#$stmt .= " \)";
	return $stmt;
}



1;
















1;
