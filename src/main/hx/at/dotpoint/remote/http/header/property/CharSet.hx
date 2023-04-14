package at.dotpoint.remote.http.header.property;

import at.dotpoint.validation.Assert;

/**
 *
 */
abstract CharSet(String) from String to String {
	public static var UTF8(default, never) = new CharSet("utf-8");

	//
	inline public function new(source:String) {
		#if debug
			validate(source);
		#end

		this = source;
	}

	public static function validate(source:String):Void {
		Assert.notNull(source);

		if (source.length < 1)
			throw 'invalid charset: $source';

		if (StringTools.trim(source).toLowerCase() != source)
			throw 'invalid charset formatting: $source';
	}
}
