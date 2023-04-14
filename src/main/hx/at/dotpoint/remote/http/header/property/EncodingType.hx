package at.dotpoint.remote.http.header.property;

import at.dotpoint.validation.Assert;

/**
 *
 */
abstract EncodingType(String) from String to String {
	public static var GZIP(default, never) 		= new EncodingType("gzip");
	public static var DEFLATE(default, never) = new EncodingType("deflate");
	public static var BR(default, never) 			= new EncodingType("br");

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

		if (source.length < 1)
			throw 'invalid encoding type: $source';

		if (StringTools.trim(source).toLowerCase() != source)
			throw 'invalid encoding type formatting: $source';
	}
}
