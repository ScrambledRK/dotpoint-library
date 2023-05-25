package sys.at.dotpoint.remote.socket;

import hx.at.dotpoint.time.Timestamp;
import hx.at.dotpoint.logging.Log;
import hx.at.dotpoint.exception.IllegalStateException;
import hx.at.dotpoint.validation.Assert;
import sys.net.Socket;

class SocketServer {
	private var socket:Socket;

	public var isRunning(default, null):Bool;

  //
	public function new(socket:Socket) {
		this.socket = Assert.notNull(socket);
	}

	//
	public function start() {
    if(isRunning)
      throw new IllegalStateException("cannot start, server already running");

    this.isRunning = true;
    this.process();
  }

  //
	public function stop() {
    if(!isRunning)
      throw new IllegalStateException("cannot stop, server is not running");

    this.isRunning = false;
  }

  //
  private function process() {
    if(!isRunning)
      return;

    // ------- //
    // accept

    var handlers:Array<SocketRequestHandler> = [];
    var timer:Timestamp = new Timestamp();

    while (!timer.isPast()){
      try {
        var client:Socket = this.socket.accept();

        if(client != null){
          handlers.push( createRequestHandler(client) );  
        }
      } catch(e:haxe.io.Error){
        switch(e){
          case Blocked:
            Log.debug('socket accept blocked');
            break; 
          default:
            Log.error('socket accept failed with io error: $e');
        }
      } catch(e:Any){
        Log.error('socket accept failed with: $e');
      }      
    }

    // ------- //
    // read

    for (client in handlers) {
      //client.
    }
  }

  //
  private function createRequestHandler(client:Socket):SocketRequestHandler {
    return new SocketRequestHandler(client);
  }
}
