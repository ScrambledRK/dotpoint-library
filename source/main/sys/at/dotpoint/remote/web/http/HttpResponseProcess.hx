package at.dotpoint.remote.web.http;

import at.dotpoint.remote.http.Request;
import at.dotpoint.remote.http.Response;
import at.dotpoint.remote.routing.IRequestRouter;
import haxe.io.Bytes;

#if neko
private typedef Web = neko.Web;
private typedef Lib = neko.Lib;
#elseif php
private typedef Web = php.Web;
private typedef Lib = php.Lib;
#end

/**
 *
 */
class HttpResponseProcess implements IRemoteProcess<Dynamic>
{

	//
	public var request(default, null):Request;
	public var router(default, null):IRequestRouter;

	//
	private var resolve:Void->Void;
	private var reject:Dynamic->Void;

	// ************************************************************************ //
	// Constructor
	// ************************************************************************ //

	public function new( request:Request, router:IRequestRouter )
	{
		this.request = request;
		this.router = router;
	}

	// ************************************************************************ //
	// Methods
	// ************************************************************************ //

	//
	public function process( stream:Dynamic ):Void
	{
		var callback = function( response:Response<Bytes> ):Void
		{
			trace( ">> response:" );
			trace( response.header.toString( ) );

			if( response.header.status != null )
				Web.setReturnCode( response.header.status );

			for( key in response.header.keys( ) )
				Web.setHeader( this.getHeaderKey( key ), response.header.get( key ) );

			if( response.body != null )
				Lib.print( response.body.toString() );

			trace( "<<" );

			//
			this.resolve( );
		};

		this.router.process( this.request, callback );
	}

	//
	inline private function getHeaderKey( key:String ):String
	{
		if( key == "content-type" )	 // neko vm: mod_neko issue and/or with the nekotools webserver
			return "Content-Type";

		return key;
	}

	//
	public function then( resolve:Void->Void, ?reject:Dynamic->Void ):Void
	{
		this.resolve = resolve;
		this.reject = reject;
	}
}
