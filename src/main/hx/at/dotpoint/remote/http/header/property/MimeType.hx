package hx.at.dotpoint.remote.http.header.property;

import hx.at.dotpoint.validation.Assert;

/**
 * text/html; charset=UTF-8
 * application/xhtml+xml,application/xml;q=0.9
 */
abstract MimeType(String) from String to String {
	public static var JSON(default, never) 	= new MimeType("application/json");
	public static var HAXE(default, never) 	= new MimeType("application/haxe");
	public static var XML(default, never) 	= new MimeType("application/xml");
	public static var XHTML(default, never) = new MimeType("application/xhtml+xml");
	public static var TEXT(default, never) 	= new MimeType("text/plain");
	public static var HTML(default, never) 	= new MimeType("text/html");
	public static var CSS(default, never) 	= new MimeType("text/css");
	public static var JS(default, never) 		= new MimeType("text/javascript");
	public static var WEBP(default, never) 	= new MimeType("image/webp");
	public static var PNG(default, never) 	= new MimeType("image/apng");
	public static var JPG(default, never) 	= new MimeType("image/jpg");
	public static var ALL(default, never) 	= new MimeType("*/*");

	//
	public var type(get, never):String;
	public var subtype(get, never):String;

	// ************************************************************************ //
	// ************************************************************************ //
	// Constructor

	//
	inline public function new(source:String) {
		#if debug
			validate(source);
		#end

		//
		this = source;
	}

	//
	public static function validate(source:String):Void {
		Assert.notNull(source);

		if (source.length < 3 || source.indexOf("/") < 0)
			throw 'invalid mime type: $source';

		if (StringTools.trim(source).toLowerCase() != source)
			throw 'invalid mime type formatting: $source';
	}

	// ************************************************************************ //
	// ************************************************************************ //
	// getter/setter

	//
	private inline function get_type():String {
		return this.split("/")[0];
	}

	//
	private inline function get_subtype():String {
		return this.split("/")[1];
	}

	//
	@:to
	public function asContentType():ContentType {
		return new ContentType(this);
	}

	//
	@:to
	public function asAccept():Accept {
		return new Accept(this);
	}

}
