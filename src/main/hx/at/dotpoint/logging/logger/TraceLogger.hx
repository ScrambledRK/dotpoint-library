package at.dotpoint.logging.logger;

import at.dotpoint.logging.Log;
import at.dotpoint.logging.LogType;
import at.dotpoint.logging.formatter.IFormatter;
import haxe.PosInfos;

//
class TraceLogger extends ILogger.BaseLogger implements ILogger {
	//
	public function new(?formatter:IFormatter) {
		super(formatter);
	}

	//
	public function log(type:LogType, msg:Dynamic, info:PosInfos):Void {
		Log.nativeTrace(this.formatter.format(type, msg, info), info);
	}
}
