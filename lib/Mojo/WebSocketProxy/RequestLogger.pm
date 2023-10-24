use Object::Pad;

class Mojo::WebSocketProxy::RequestLogger;

use strict;
use warnings;
use Log::Any qw($log);
use UUID::Tiny;

field $context; 

our $handler = sub {
    my ($context, $message) = @_;
    $log->warn($message, $context);
};

sub set_handler {
    my ($self, $h) = @_;
    $handler = $h;
} 

BUILD {
    $context->{cid} = UUID::Tiny::create_UUID_as_string(UUID::Tiny::UUID_V4);
}

method infof ($message) {
    $handler->($context, $message, 'infof');
}

1;
