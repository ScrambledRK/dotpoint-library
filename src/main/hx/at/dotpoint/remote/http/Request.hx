package at.dotpoint.remote.http;

import at.dotpoint.validation.Assert;
import at.dotpoint.remote.http.header.property.Accept;
import at.dotpoint.remote.http.header.property.MimeType;
import at.dotpoint.remote.http.header.property.Method;
import at.dotpoint.remote.http.header.RequestHeader;
import at.dotpoint.remote.http.url.Parameters;

/**
 * GET / HTTP/1.1
 */
class Request<T:Any> {
	@:isVar public var url(default,null):String;
	@:isVar public var parameter(default,null):Parameters;

	@:isVar public var header(default,null):RequestHeader;
	@:isVar public var method(default,null):Method;
	@:isVar public var body(default,null):Null<T>;

	// ************************************************************************ //
	// ************************************************************************ //
	// Constructor

	//
	public function new(url:String, ?method:Method, ?header:RequestHeader, ?body:T) {
		this.url = Assert.notNull(url);
		this.parameter = Parameters.decode(this.url);

		this.method = method != null ? method : Method.GET;
		this.header = header != null ? header : new RequestHeader();
		this.body = body;
	}

	//
	public function clone():Request<T> {
		var header:RequestHeader = cast this.header.copy();
		return new Request(this.url, this.method, header, body);
	}

	// ************************************************************************ //
	// ************************************************************************ //
	// Methods

	//
	public function accepts(possible:Iterable<MimeType>):MimeType {
		var list:Array<Accept> = this.header.accept;

		if (list == null || list.length == 0) // TODO: guess accept type by url?
			return null;

		//
		var st = null;
		var sq:Float = -1;

		for (p in possible) {
			for (v in list) {
				var vq = v.q;
				var vt = v.type;

				if (vt == p && vq > sq) { // find highest quality
					st = vt;
					sq = vq;
				}
			}
		}

		return st;
	}

	// ------------------------------------------------------------------------ //
	// ------------------------------------------------------------------------ //
	//

	public function toString():String {
		return '[Request: $method $url]';
	}
}
