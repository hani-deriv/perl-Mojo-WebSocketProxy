use Object::Pad;

class Mojo::WebSocketProxy::RequestLogger;

use strict;
use warnings;
use Log::Any qw($log);

field $req_storage: param;

method infof ($message) {
    $log->adapter->set_context($req_storage->{cid});
    $log->infof($message);
    $log->adapter->clear_context;
}

1;
