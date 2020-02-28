package MyTable;

use Moo;
use namespace::autoclean;
use Data::Printer;

with 'Table';

sub db {

  DBObject->new(
    source=>"dbi:SQLite:dbname=test.db",
    user=>"",
    auth=>"",
    options=>{sqlite_unicode => 1,RaiseError => 1, AutoCommit => 1},
  );
}

sub schema {
  Schema->new(
    name => 'company',
    fields => [
      Field->new(name=>'name',type=>'VARCHAR',len=>60,primary=>1),
      Field->new(name=>'property',type=>'NUM',len=>12,default=>0.0,not_null=>1),
      Field->new(name=>'people',type=>'NUM',len=>10,not_null=>1),
    ],
  );
}



1;
__END__
add_field({name=>'name',type=>'VARCHAR',len=>60,unique=>1});
add_field({name=>'property',type=>'NUM',len=>12,default=>0.0,not_null=>1});
add_field({name=>'people',type=>'NUM',len=>10,not_null=>1});



1;
