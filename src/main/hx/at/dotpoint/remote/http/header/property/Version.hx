package hx.at.dotpoint.remote.http.header.property;

import haxe.display.Protocol.Version;
import hx.at.dotpoint.validation.Assert;

/**
 *
 */
abstract Version(String) from String to String {
	public static var HTTP11(default, never) = new Version("http/1.1");
	public static var HTTP20(default, never) = new Version("http/2.0");

	//
	public var type(get, never):String;
	public var version(get, never):String;

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
	private static function validate(source:String){
		Assert.notNull(source);

		if (source.length < 3 || source.indexOf("/") < 0)
			throw 'invalid protocol: $source';

		if (StringTools.trim(source).toLowerCase() != source)
			throw 'invalid protocol formatting: $source';
	}

	// ************************************************************************ //
	// ************************************************************************ //
	// Methods

	//
	private inline function get_type():String {
		return this.split("/")[0];
	}

	//
	private inline function get_version():String {
		return this.split("/")[1];
	}
}
