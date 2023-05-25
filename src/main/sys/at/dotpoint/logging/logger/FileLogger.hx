package sys.at.dotpoint.logging.logger;

import haxe.PosInfos;
import hx.at.dotpoint.validation.Assert;
import sys.FileSystem;
import sys.io.File;
import sys.io.FileOutput;
import hx.at.dotpoint.logging.formatter.IFormatter;
import hx.at.dotpoint.logging.logger.ILogger;
import hx.at.dotpoint.logging.LogType;

/**
	logs to a file
**/
class FileLogger extends ILogger.BaseLogger implements ILogger {
	private var logFilePath:String;
	private var maxFileSize:Int;

	//
	public function new(?formatter:IFormatter, logFilePath:String, maxFileSize:Int = 0) {
		super(formatter);

		this.logFilePath = Assert.notEmpty(logFilePath);
		this.maxFileSize = Assert.isMinInclusive(maxFileSize, 0);
	}

	//
	public function log(type:LogType, msg:Dynamic, info:PosInfos):Void {
		var result:String = formatter.format(type, msg, info);

		// reset log max file size reached
		if (maxFileSize > 0 && FileSystem.exists(logFilePath)) {
			if (FileSystem.stat(logFilePath).size > maxFileSize)
				FileSystem.deleteFile(logFilePath);
		}

		var output:FileOutput = File.append(logFilePath, false);
				output.writeString(result += "\n");
				output.close();
	}
}
