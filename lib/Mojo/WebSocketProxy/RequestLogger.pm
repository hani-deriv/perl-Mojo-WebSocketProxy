use Object::Pad;

class Mojo::WebSocketProxy::RequestLogger;

use strict;
use warnings;
use Log::Any qw($log);
use UUID::Tiny;

field $context; 

our $handler = sub {
    my ($level, $message, $context, @params) = @_;
    
    if(scalar @params) {
        return $log->$level($message, @params);
    }

    return $log->$level($message, $context);
};

sub set_handler {
    my ($self, $h) = @_;
    $handler = $h;
} 

BUILD {
    $context->{cid} = UUID::Tiny::create_UUID_as_string(UUID::Tiny::UUID_V4);
}

method infof ($message, @params) {
    $handler->('infof', $message, $context, @params);
}

method info($message) {
    $handler->('info', $message, $context);
}

1;
