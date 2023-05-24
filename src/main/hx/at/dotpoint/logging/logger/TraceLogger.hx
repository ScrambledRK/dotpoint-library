package hx.at.dotpoint.logging.logger;

import hx.at.dotpoint.logging.Log;
import hx.at.dotpoint.logging.LogType;
import hx.at.dotpoint.logging.formatter.IFormatter;
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
