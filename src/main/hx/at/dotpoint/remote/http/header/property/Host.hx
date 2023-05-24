package hx.at.dotpoint.remote.http.header.property;

import hx.at.dotpoint.validation.Assert;
import Std;

/**
 * localhost:2007
 */
abstract Host(String) from String to String {
	public var host(get, never):String;
	public var port(get, never):Int;

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
	public static function validate(source:String){
		Assert.notNull(source);

		if (source.length < 3 || source.indexOf(":") < 0)
			throw 'invalid host: $source';

		if (StringTools.trim(source).toLowerCase() != source)
			throw 'invalid host formatting: $source';

		//
		if (getPort(source) >= 0){
			var port:Int = getPort(source);

			Assert.isMinExclusive(port, 0);
			Assert.isMaxExclusive(port, 65535);
		}
	}

	// ************************************************************************ //
	// ************************************************************************ //
	// getter/setter

	//
	private inline function get_host():String {
		return this.split(":")[0];
	}

	//
	private inline function get_port():Int {
		return getPort(this);
	}

	//
	inline private static function getPort(value:String):Int {
		return value.indexOf(":") == -1 ? -1 : Std.parseInt(value.split(":")[1]);
	}

	//
	public inline function hasPort():Bool {
		return getPort(this) >= 0;
	}
}
