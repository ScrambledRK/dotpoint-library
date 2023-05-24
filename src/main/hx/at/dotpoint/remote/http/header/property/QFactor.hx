package hx.at.dotpoint.remote.http.header.property;

import hx.at.dotpoint.validation.Assert;

/**
 * application/xhtml+xml,application/xml;q=0.9
 */
abstract QFactor(Float) from Float to Float {
	//
	inline public function new(source:Float) {
		#if debug
			validate(source);
		#end

		this = source;
	}

	//
	public static function validate(source:Float) {
		Assert.isMinExclusive(source, 0.0);
		Assert.isMaxInclusive(source, 1.0);
	}

	//
	@:op(A > B) static function gt(a:QFactor, b:QFactor):Bool;
	@:op(A < B) static function lt(a:QFactor, b:QFactor):Bool;
}
