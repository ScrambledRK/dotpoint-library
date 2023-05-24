package sys.at.dotpoint.logging.logger;

import haxe.PosInfos;
import hx.at.dotpoint.logging.LogType;
import hx.at.dotpoint.logging.formatter.IFormatter;
import hx.at.dotpoint.logging.logger.ILogger;

/**
	logs to system out (or system err in case of error)
**/
class SystemLogger extends ILogger.BaseLogger implements ILogger {
	//
	public function new(?formatter:IFormatter) {
		super(formatter);
	}

	//
	public function log(type:LogType, msg:Dynamic, info:PosInfos):Void {
		var output = this.formatter.format(type, msg, info) + "\n\r";

		switch (type) {
			case LogType.ERROR | LogType.UNCAUGHT:
				Sys.stderr().writeString(output);

			default:
				Sys.stdout().writeString(output);
		}
	}
}
