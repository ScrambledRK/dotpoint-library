package sys.at.dotpoint.remote.socket;

import hx.at.dotpoint.validation.Assert;
import sys.net.Socket;
import haxe.io.Output;
import haxe.io.Input;

class SocketRequestHandler implements RequestHandler<Input,Output>{
  public var client(default,null):Socket;

	private var input(get, null):Input;
	private var output(get, null):Output;

  //
  public function new(client:Socket) {
    this.client = Assert.notNull(client);

    client.setBlocking(false);
    client.setFastSend(false);
    client.setTimeout(10);
  }

  //
  private function get_input():Input {
		return client.input;
	}

	private function get_output():Output {
		return client.output;
	}	
}