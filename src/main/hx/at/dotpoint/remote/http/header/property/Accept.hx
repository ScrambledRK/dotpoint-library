package at.dotpoint.remote.http.header.property;

import at.dotpoint.validation.Assert;
import Std;

/**
 * text/html; charset=UTF-8
 * application/xhtml+xml,application/xml;q=0.9
 */
abstract Accept(String) from String to String {
	/**
		e.g.: text/html; charset=UTF-8
	**/
	public var type(get, never):MimeType;

	/**
		e.g.: q=0.9
	**/
	public var q(get, never):QFactor;

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
			throw 'invalid accept $source';

		if (StringTools.trim(source).toLowerCase() != source)
			throw 'invalid accept formatting: $source';

		getType(source);
		getQFactor(source);
	}

	// ----------------------------------------------------------------------- //
	// ----------------------------------------------------------------------- //

	//
	public static function from(type:MimeType, q:QFactor):Accept {
		var st:String = Std.string(type);
		var sq:String = Std.string(q);

		return new Accept([st, sq].join(";q=")); // hack to avoid inline and + operation
	}

	// ************************************************************************ //
	// ************************************************************************ //
	// Methods

	//
	inline private function get_type():MimeType {
		return getType(this);
	}

	//
	inline private function get_q():QFactor {
		return getQFactor(this);
	}

	//
	inline private static function getType(value:String):MimeType {
		return new MimeType(value.split(";")[0]);
	}

	//
	inline private static function getQFactor(value:String):QFactor {
		var idx:Int = value.indexOf(";q=");

		if (idx < 0)
			return 0;

		return Std.parseFloat(value.substring(idx + 3));
	}
}
