package hx.at.dotpoint.logging.logger;

import hx.at.dotpoint.logging.LogType;
import hx.at.dotpoint.logging.formatter.IFormatter;
import haxe.PosInfos;

/**
	logger interface
**/
interface ILogger {
	/**
		@param	type 	info, error, etc.
		@param	msg		the actual message to log
		@param	info	automatically injected metadata (file, line, etc.)
	**/
	public function log(type:LogType, msg:Dynamic, info:PosInfos):Void;	
}

/**
	basic implementation
**/
class BaseLogger {
	public var formatter(default, null):IFormatter;

	//
	public function new(?formatter:IFormatter) {
		this.formatter = formatter != null ? formatter : new NullFormatter();
	}
}

/**
	does nothing
**/
class NullLogger implements ILogger {
	//
	public function new() {
	}

	//
	public function log(type:LogType, msg:Dynamic, info:PosInfos):Void {
		return;
	}
}
