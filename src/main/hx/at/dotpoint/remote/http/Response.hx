package hx.at.dotpoint.remote.http;

import hx.at.dotpoint.remote.http.header.ResponseHeader;

/**
 *
 */
class Response<T:Any> {
	public var header:ResponseHeader;
	public var body:Null<T>;

	// ************************************************************************ //
	// ************************************************************************ //
	// Constructor

	//
	public function new(?header:ResponseHeader, ?body:T) {
		this.header = header != null ? header : new ResponseHeader();
		this.body = body;
	}
}
