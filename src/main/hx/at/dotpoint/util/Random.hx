package hx.at.dotpoint.util;

//
class Random {
	//
	public static function shuffleArray<T>(output:Array<T>):Array<T> {
		if (output != null) {
			for (i in 0...output.length) {
				var j = Random.int(0, output.length - 1);
				var a = output[i];
				var b = output[j];
				output[i] = b;
				output[j] = a;
			}
		}

		return output;
	}

	//
	public static inline function int(from:Int, to:Int):Int {
		return from + Math.floor(((to - from + 1) * Math.random()));
	}
}
