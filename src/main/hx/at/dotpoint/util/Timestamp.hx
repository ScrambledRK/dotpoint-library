package hx.at.dotpoint.util;

import haxe.Timer;

//
abstract Timestamp(Float) from Float to Float {
	inline public function new(?value:Float) {
		if (value == null)
			value = Timer.stamp();

		this = value;
	}

	//
	inline public function isLate(limit:Float = 0.3):Bool {
		return Timer.stamp() - this > limit;
	}

	inline public function reset():Timestamp {
		return this = Timer.stamp();
	}
}
