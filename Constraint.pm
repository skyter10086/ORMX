package Constraint;

use Moo::Role;
use namespace::autoclean;

has default => (
    is => 'rw',

);

has unique => (
    is => 'rw',

);



has not_null => (
    is => 'rw',

);

has primary => (
    is => 'rw',

);



1;
