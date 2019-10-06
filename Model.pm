package Model;

use Moo::Role;
use namespace::autoclean;
use Data::Printer;

requires 'map','table';

=pod
my $table;


sub set_table {
    #my $self =shift;	
    $table = shift;
}

sub table {
	my $self =shift;
    return $table;	
}

sub map {...}
=cut

sub attr_hash {
	my $self = shift;
	my $meta = $self->meta;
    my %obj_hash;
    for my $attr ($meta->get_all_attributes) {
        my $reader = $attr->get_read_method;
        my $attr_val = $self->$reader;
        $obj_hash{$attr->name} = $attr_val;
	    } 
     return \%obj_hash ;
	
}



sub save {
	my $self =shift;
	my $table = $self->table;
	my $map = $self->map;
	my $pk = $table->schema->pk;
	my %reversed_map = reverse %$map;
	my $pk_attr = $reversed_map{$pk};
	my $pk_val = $self->attr_hash->{$pk_attr};
	my $filter = {$pk=>$pk_val};
	my $search_result = $table->select(undef,$filter);
	my $exist = $search_result->count;
	my $attr_hash = $self->attr_hash;
	#p $attr_hash;
	my %field_hash;
	for my $f_i (keys %reversed_map) {
		my $attr_name = $reversed_map{$f_i};
	    $field_hash{$f_i} = $attr_hash->{$attr_name};
	}
	if ($exist) {
		$table->update($filter,\%field_hash);
	} else {
		$table->insert(\%field_hash);
	}
}

sub clear {

	my $self =shift;
	my $attr_hash = $self->attr_hash;
	for my $attr_name (keys %$attr_hash) {
	   $self->$attr_name(undef); 	
	}
}

sub load {
    my $self = shift;
    my $pk_attrname ;
    my $pk_attrval;
    my $pk_val = shift;
    my $attr_hash = $self->attr_hash;
    my $map = $self->map;
    my %reversed_map = reverse %$map;
    $pk_attrname = $reversed_map{$self->table->schema->pk};
    $pk_attrval = $attr_hash->{$pk_attrname};
    
    if ($pk_val) {
		$self->__update_attr($pk_val);
	} else {
	    if ($pk_attrval) {
		    $self->__update_attr($pk_attrval)	
		} else {
		    $self->clear;
		}	
	}	
	
}

sub __update_attr {
    my $self = shift;
    my $map = $self->map;
    my $pk_val = shift;
    my $attr_hash = $self->attr_hash;
    
    my $fields= $self->table->schema->fields;
    my @fields_name;
    @fields_name = map {$_->name} @$fields;
    my $res_new = $self->table
                       ->select(
                       \@fields_name,
                       {$self->table->schema->pk => $pk_val});
    if ($res_new->count) {
		for my $attr_name (keys %$attr_hash) {
			my $field_name = $map->{$attr_name};
		    $self->$attr_name($res_new->single->$field_name);
		}
	} else {
	    $self->clear;
	}
    	
}
	
	
=pod	
	my ($self) = @_;
	my $pk = $table->schema->pk;
	my $val = $self->$pk;
	my $search_result = $table->select(undef,{$pk=>$val});
	my $attr_hr = $self->attr_hash;
	my $maps = $self->map;
	delete ${%$maps}{$pk};
	#delete ${%$attr_hash}{$pk};
	my $maps_reverse = reverse %$maps;
	my $maps_for_update = map {$_, $attr_hr->{$maps_reverse->{$_}}}  (keys %$maps_reverse);
	if ($search_result->count) {
	    $table->update({$pk=>$val},$maps_for_update);
	} else {
	    $table->insert($attr_hr);	
	}
=cut	




#sub clear {}















1;
