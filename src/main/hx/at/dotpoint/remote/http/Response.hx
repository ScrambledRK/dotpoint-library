package hx.at.dotpoint.remote.http;

import hx.at.dotpoint.validation.Assert;
import hx.at.dotpoint.remote.http.header.property.Version;
import hx.at.dotpoint.remote.http.header.property.Status;
import hx.at.dotpoint.remote.http.header.ResponseHeader;

/**
 *
 */
class Response<T:Any> {
  @:isVar public var status(default, null):Status;

	@:isVar public var version(default, null):Version;
	@:isVar public var header:ResponseHeader;
	@:isVar public var body:Null<T>;

  // ************************************************************************ //
  // ************************************************************************ //
  // Constructor
  //
  public function new(status:Status, ?version:Version, ?header:ResponseHeader, ?body:T) {
    this.status = Assert.notNull(status);

    this.version = version != null ? version : Version.HTTP11;
    this.header = header != null ? header : new ResponseHeader();
    this.body = body;
  }

  // ------------------------------------------------------------------------ //
  // ------------------------------------------------------------------------ //
  //

  public function toString():String {
    return '[Response: $status]';
  }
}
