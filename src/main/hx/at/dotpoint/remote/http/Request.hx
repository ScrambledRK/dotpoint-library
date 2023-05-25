package hx.at.dotpoint.remote.http;

import hx.at.dotpoint.remote.http.header.RequestHeader;
import hx.at.dotpoint.remote.http.header.property.Accept;
import hx.at.dotpoint.remote.http.header.property.Method;
import hx.at.dotpoint.remote.http.header.property.MimeType;
import hx.at.dotpoint.remote.http.header.property.Version;
import hx.at.dotpoint.remote.http.url.Parameters;
import hx.at.dotpoint.remote.http.url.Url;
import hx.at.dotpoint.validation.Assert;

/**
 * GET / HTTP/1.1
 */
class Request<T:Any> {
  @:isVar public var url(default, null):Url;
  @:isVar public var method(default, null):Method;
	
  @:isVar public var version(default, null):Version;
  @:isVar public var header(default, null):RequestHeader;
  @:isVar public var body(default, null):Null<T>;

  // ************************************************************************ //
  // ************************************************************************ //
  // Constructor
  //
  public function new(url:Url, ?method:Method, ?version:Version, ?header:RequestHeader, ?body:T) {
    this.url = Assert.notNull(url);
    this.method = method != null ? method : Method.GET;
		
    this.version = version != null ? version : Version.HTTP11;
    this.header = header != null ? header : new RequestHeader();
    this.body = body;
  }

  // ------------------------------------------------------------------------ //
  // ------------------------------------------------------------------------ //
  //

  public function toString():String {
    return '[Request: $method $url]';
  }
}
