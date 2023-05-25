package hx.at.dotpoint.time;

import haxe.Timer;

//
abstract Timestamp(Float) from Float to Float {
	inline public function new(?value:Float) {
		if (value == null)
			value = Timer.stamp();

		this = value;
	}

	//
	inline public function isPast(seconds:Float = 0.3):Bool {
		return Timer.stamp() - this > seconds;
	}

	inline public function reset():Timestamp {
		return this = Timer.stamp();
	}
}
