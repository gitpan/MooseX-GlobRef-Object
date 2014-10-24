package MooseX::GlobRef::Meta::ClassImmutableTest;

use base 'Test::Unit::TestCase';

use Scalar::Util;


package MooseX::GlobRef::Meta::ClassImmutableTest::Test1;

# Use just class metaclass without instance metaclass, so original hashref
# object will be used.

use metaclass 'MooseX::GlobRef::Meta::Class';

use Moose;

has field => ( is => 'rw' );

__PACKAGE__->meta->make_immutable;


package MooseX::GlobRef::Meta::ClassImmutableTest;

sub test_MooseX_GlobRef_Meta_Class___isa {
    my $self = shift;
    my $obj = MooseX::GlobRef::Meta::ClassImmutableTest::Test1->new;
    $self->assert_not_null($obj);
    $self->assert($obj->isa('MooseX::GlobRef::Meta::ClassImmutableTest::Test1'));
    $self->assert_equals('HASH', Scalar::Util::reftype($obj));
}

sub test_MooseX_GlobRef_Meta_Class_accessor {
    my $self = shift;
    my $obj = MooseX::GlobRef::Meta::ClassImmutableTest::Test1->new(field => $$);
    $self->assert_not_null($obj);
    $self->assert($obj->isa('MooseX::GlobRef::Meta::ClassImmutableTest::Test1'));
    $self->assert_equals($$, $obj->field);
    $self->assert_equals(1, $obj->field(1));
    $self->assert_equals(1, $obj->field);
}

1;
