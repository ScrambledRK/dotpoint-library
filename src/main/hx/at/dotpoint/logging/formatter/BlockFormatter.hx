package at.dotpoint.logging.formatter;

import haxe.PosInfos;

/**
	uses ">>" and "<<" indicators at the beginning of the log message to 
	indent the log and all following logs. this way "log blocks" can be
	opened and closed ...
**/
class BlockFormatter implements IFormatter {
	private var step:Int;
	private var space:String;

	// ************************************************************************ //
	// ************************************************************************ //
	// Constructor

	public function new(space:String = "  ") {
		this.step = 0;
		this.space = space;
	}

	// ************************************************************************ //
	// ************************************************************************ //
	// Methods

	//
	public function format(type:LogType, msg:Dynamic, info:PosInfos):String {
		return this.prefix(type, msg, info) + this.message(type, msg, info);
	}

	//
	private function prefix(type:LogType, msg:Dynamic, info:PosInfos):String {
		if (this.step < 0)
			this.step = 0;

		//
		var result:String = this.padding();
		
		if (Std.isOfType(msg, String)) {
			var code:String = Std.string(msg).substring(0, 2);

			if (code == ">>") {
				this.step++;
			}

			if (code == "<<") {
				this.step--;
				result = this.padding();
			}
		}

		return result;
	}

	//
	private function padding():String {
		var prefix:String = space;

		for (j in 0...this.step)
			prefix += space;

		return prefix;
	}

	//
	private function message(type:LogType, msg:Dynamic, info:PosInfos):String {
		var result:String = Std.string(msg);
		var padding:String = this.padding();

		if (info.customParams != null) {
			for (param in info.customParams)
				result += "," + Std.string(param);
		}

		return result.split("\n").join("\n" + padding);
	}
}
