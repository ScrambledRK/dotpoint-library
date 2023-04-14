package at.dotpoint.remote.http.header.property;

import at.dotpoint.validation.Assert;

/**
 * text/html; charset=UTF-8
 * application/xhtml+xml,application/xml;q=0.9
 */
abstract ContentType(String) from String to String {
	/**
		e.g.: application/xhtml+xml
	**/
	public var type(get, never):MimeType;

	/**
		e.g.: UTF-8
	**/
	public var charset(get, never):Null<CharSet>;

	// ************************************************************************ //
	// ************************************************************************ //
	// Constructor

	//
	inline public function new(source:String) {
		#if debug
			validate(source);
		#end

		this = source;
	}

	//
	public static function validate(source:String):Void {
		Assert.notNull(source);

		getType(source);
		getCharset(source);
	}

	// ----------------------------------------------------------------------- //
	// ----------------------------------------------------------------------- //

	//
	public static function from(type:MimeType, ?charset:CharSet):ContentType {
		if(charset == null){
			return new ContentType(type);
		}

		var st:String = Std.string(type);
		var sc:String = Std.string(charset);

		return new ContentType([st, sc].join(";charset=")); // hack to avoid inline and + operation
	}

	// ************************************************************************ //
	// ************************************************************************ //
	// Methods

	//
	inline private function get_type():MimeType {
		return getType(this);
	}

	//
	inline private function get_charset():Null<CharSet> {
		return getCharset(this);
	}

	//
	inline private static function getType(value:String):MimeType {
		return new MimeType(value.substring(value.indexOf(";")));
	}

	//
	inline private static function getCharset(value:String):Null<CharSet> {
		var idx:Int = value.indexOf("charset=");

		if (idx < 0)
			return null;

		return new CharSet(value.substring(idx));
	}
}
