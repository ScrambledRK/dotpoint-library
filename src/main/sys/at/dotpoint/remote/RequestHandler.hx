package sys.at.dotpoint.remote;

import hx.at.dotpoint.validation.Assert;
import haxe.io.Output;
import haxe.io.Input;

interface RequestHandler<I:Input, O:Output> {
	private var input(get,null):I;
	private var output(get,null):O;
}
