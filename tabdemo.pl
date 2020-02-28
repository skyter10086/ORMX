use lib './';
use TabDemo;
use Data::Printer;
use DBObject;
#use Schema;
=pod
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
=cut
my $tab = TabDemo->new;
#p $tab;
#$tab->db(DBO->new);
#my $dbx = $tab->connect('dbi:SQLite:dbname=my.db','','',{sqlite_unicode => 1,RaiseError => 1, AutoCommit => 1});
=pod
$tab->schem(Schema->new(
     name => 'company',
     fields => [
            Field->new(name=>'name',type=>'VARCHAR',len=>60,primary=>1),
            Field->new(name=>'property',type=>'NUM',len=>12,default=>0.0,not_null=>1),
            Field->new(name=>'people',type=>'NUM',len=>10,not_null=>1),
     ],
));
=cut
p $tab->schema;
p $tab->connect->dbh;
