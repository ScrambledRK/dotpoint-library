package at.dotpoint.remote.http;

import at.dotpoint.remote.http.header.Accept;
import at.dotpoint.remote.http.header.MimeType;
import at.dotpoint.remote.http.request.RequestHeader;
import at.dotpoint.remote.http.request.Method;
import at.dotpoint.remote.http.request.Parameters;

/**
 * GET / HTTP/1.1
 */
class Request
{

	public var url:String;
	public var parameter:Parameters;

	public var header:RequestHeader;
	public var method:Method;

	// ************************************************************************ //
	// Constructor
	// ************************************************************************ //

	//
	public function new( url:String, ?method:Method, ?header:RequestHeader )
	{
		this.url = url;
		this.parameter = url != null ? Parameters.decode( this.url ) : null;

		this.method = method != null ? method : Method.GET;
		this.header = header != null ? header : new RequestHeader();
	}

	//
	public function clone():Request
	{
		var header:RequestHeader = cast this.header.copy();

		var result = new Request( this.url, this.method, header );
			result.parameter = cast this.parameter != null ? this.parameter.copy() : null;

		return result;
	}

	// ************************************************************************ //
	// Methods
	// ************************************************************************ //

	//
	public function accepts( possible:Iterable<MimeType> ):MimeType
	{
		var list:Array<Accept> = this.header.accept;

		if( list == null || list.length == 0 )	// TODO: guess accept type by url?
			return null;

		//
		var st = null;
		var sq:Float = -1;

		for( p in possible )
		{
			for( v in list )
			{
				var vq = v.q;
				var vt = v.type;

				if( vt == p && vq > sq )
				{
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
	public function toString():String
	{
		return '[Request: $method $url]';
	}
}
