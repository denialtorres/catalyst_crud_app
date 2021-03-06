package AddressBook::Controller::Person;
use Moose;
use Pry;
use namespace::autoclean;

BEGIN { extends 'Catalyst::Controller'; }

=head1 NAME

AddressBook::Controller::Person - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


=head2 index

=cut

# sub index :Path :Args(0) {
#     my ( $self, $c ) = @_;
#
#     $c->response->body('Matched AddressBook::Controller::Person in Person.');
# }
sub index{}

sub list : Local {
  my ($self, $c ) =@_;
  my $people = $c->model('AddressDB::Person');
  $c->stash->{people} = $people;
}

sub delete : Local {
  my ($self, $c, $id) = @_;
  my $person = $c->model('AddressDB::Person')->find({id=> $id});
  $c->stash->{person} = $person;

  if($person){
    $c->stash->{message} = 'Deleted '.$person->name;
    $person->delete;
  }else{
    $c->response->status(404);
    $c->stash->{error} = "No Person $id";
  }
  $c->forward('list');
  #$c->response->redirect($c->uri_for_action('person/list')) && $c->detach();
}

=encoding utf8

=head1 AUTHOR

Daniel Torres

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

1;
