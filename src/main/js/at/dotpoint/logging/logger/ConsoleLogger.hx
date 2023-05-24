package js.at.dotpoint.logging.logger;

import haxe.PosInfos;
import hx.at.dotpoint.logging.LogType;
import hx.at.dotpoint.logging.logger.ILogger;
import hx.at.dotpoint.logging.formatter.IFormatter;

/**
	logs to the browser console
**/
class ConsoleLogger extends ILogger.BaseLogger implements ILogger {
	//
	public function new(?formatter:IFormatter) {
		super(formatter);
	}

	//
	public function log(type:LogType, msg:Dynamic, info:PosInfos):Void {
		var result:String = this.formatter.format(type, msg, info);

		switch (type) {
			case DEBUG:
				js.Browser.console.debug(result);

			case WARNING:
				js.Browser.console.warn(result);

			case ERROR | UNCAUGHT:
				js.Browser.console.error(result);

			default:
				js.Browser.console.info(result);
		}
	}
}
