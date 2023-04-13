package at.dotpoint.logging.formatter;

import haxe.PosInfos;

/**
	formats a given log message to a string
**/
interface IFormatter {
	/**
		@param	type 	info, error, etc.
		@param	msg		the actual message to log
		@param	info	automatically injected metadata (file, line, etc.)
	**/
	public function format(type:LogType, msg:Dynamic, info:PosInfos):String;
}

/**
	does the bare minimum formatting
**/
class NullFormatter implements IFormatter {
	public function new() {}

	//
	public function format(type:LogType, msg:Dynamic, info:PosInfos):String {
		var result:String = Std.string(msg);

		if (info.customParams != null) {
			for (param in info.customParams)
				result += "," + Std.string(param);
		}

		return result;
	}
}
