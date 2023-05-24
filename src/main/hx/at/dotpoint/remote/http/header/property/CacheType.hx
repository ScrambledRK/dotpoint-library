package hx.at.dotpoint.remote.http.header.property;

import hx.at.dotpoint.validation.Assert;

/**
 *
 */
abstract CacheType(String) from String to String {
	//
	inline public function new(source:String) {
		#if debug
			validate(source);
		#end

		this = source;
	}

	//
	static public function validate(source:String):Void {
		Assert.notNull(source);

		if (source.length < 1)
			throw 'invalid cache type: $source';

		if (StringTools.trim(source).toLowerCase() != source)
			throw 'invalid cache type formatting: $source';
	}
}
