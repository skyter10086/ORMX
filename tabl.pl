use lib './';
use Table;
use Data::Printer;


my $table = Table->new;

$table->set_db({
    source=>"dbi:SQLite:dbname=test.db",
    user=>"",
    auth=>"",
    options=>{sqlite_unicode => 1,RaiseError => 1, AutoCommit => 1},
  });

my $dbh = $table->db->dbh;

$table->name('person');
my $n = $table->name;

print "name is $n!\n";

$table->add_field(
  Field->new(name=>'id',type=>'VARCHAR',len=>'18',primary=>1));

$table->add_field(
  Field->new(name=>'name',type=>'VARCHAR',len=>'30',not_null=>1));

$table->add_field(
  Field->new(name=>'sex',type=>'VARCHAR',len=>'6',not_null=>1));

my @fields_arr = $table->fields;

#p @fields_arr;

my $schema = $table->build;

print $schema,"\n";
$table->delete;
#$table->_init;

$table->insert({id=>'412302198310103115',name=>'ZengBoYuan',sex=>'Male'});
my $select_result = $table->select(
  ['name','sex','id'],
  {id=>'412302198310103115'});
while (my $select = $select_result->next) {
  printf "I am %s , %s and my id number is %s.\n",
  $select->name,$select->sex,$select->id;
}
#my $update_res = $select_result->update({id=>'411302198310203835'});

#my $update_res = $select_result->update({name=>'ZengLi'});
my $update_res = $table->update(undef,{name=>'ZengLi'});
#p $update_res;
=pod
while (my $up = $update_res->next) {
        printf "I am %s , %s and my id number is %s.\n",
                $up->name,$up->sex,$up->id;
}
=cut
my $del_res = $table->delete({id=>'412302198310103115'});
$table->insert({id=>'412325198310103115',name=>'ZengBoYuan',sex=>'Male'});
$table->insert({id=>'411302198310203835',name=>'ZengLi',sex=>'Male'});
my $result_set = $table->select(['sex','name','id']);
while (my $select = $result_set->next) {
  printf "I am %s , %s and my id number is %s.",
  $select->name,$select->sex,$select->id;
  print "\n";
}
#$table->delete;
#p $del_rescount;
