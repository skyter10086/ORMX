use Company;
use Data::Printer;

my $com = Company->new;


#$com->table->_init;

$com->name('DaTong');
$com->property(12000000000);
$com->count(400);
$com->save;
#p $com;
#$com->clear;
print "after clear..\n";
#p $com->table->schema->fields;
$com->name('DT');
$com->save;
p $com;
$com->load('DaTong');
p $com;
$com->count(401);
$com->save;
p $com;
