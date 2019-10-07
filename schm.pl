use Schema;

use Data::Printer;

my $scm = Schema->new(
        name => 'company',
        fields=> [
            Field->new(name=>'name',type=>'VARCHAR',len=>60,unique=>1),
            Field->new(name=>'property',type=>'NUM',len=>12,default=>0.0,not_null=>1),
            Field->new(name=>'people',type=>'NUM',len=>10,not_null=>1)],    
);

p $scm->fields;
