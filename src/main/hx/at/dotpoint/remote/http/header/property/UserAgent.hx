package hx.at.dotpoint.remote.http.header.property;

import hx.at.dotpoint.validation.Assert;

/**
 *
 */
abstract UserAgent(String) from String to String {
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
	}
}
