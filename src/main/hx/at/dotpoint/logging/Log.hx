package at.dotpoint.logging;

import at.dotpoint.logging.logger.ILogger;
import at.dotpoint.logging.logger.ILogger.NullLogger;
import at.dotpoint.logging.logger.TraceLogger;
import haxe.CallStack;
import haxe.PosInfos;

#if js
import haxe.extern.EitherType;
#end

/**
	static interface for logging
**/
class Log {
	public static var loggerList(default, null):Array<ILogger> = [new NullLogger()];
	public static var nativeTrace(default, null):Dynamic->PosInfos->Void;

	// ************************************************************************ //
	// ************************************************************************ //
	// Constructor

	/**
		must be called before using any other methods
	**/
	public static function initialize(?loggerList:Array<ILogger>, redirectTrace:Bool = true):Void {
		if (loggerList == null) {
			loggerList = new Array<ILogger>();
			loggerList.push(new TraceLogger());
		}

		Log.loggerList = loggerList;

		// --- //

		Log.nativeTrace = haxe.Log.trace;

		if (redirectTrace)
			haxe.Log.trace = Log.onTrace;

		// --- //

		#if js
		js.Browser.window.onerror = function(msg:EitherType<js.html.Event, String>, url:String, line:Int, col:Int, error:Dynamic):Bool {
			var info:PosInfos = {
				fileName: url,
				lineNumber: line,
				className: null,
				methodName: null
			}

			if (error != null && Reflect.hasField(error, "stack")) {
				var stack:Array<String> = Std.string(error.stack).split("\n");
			}

			return Log.uncaught(msg, info);
		}
		#end
	}

	// ************************************************************************ //
	// ************************************************************************ //
	// private

	/**
		used as target function when redirecting the native trace()
	**/
	private static function onTrace(value:Dynamic, ?info:PosInfos):Void {
		if (Std.isOfType(value, LogType) && info.customParams != null) {
			switch (value) {
				case LogType.ERROR:
					Log.error(info.customParams.shift(), info);

				case LogType.WARNING:
					Log.warn(info.customParams.shift(), info);

				default:
					Log.info(info.customParams.shift(), info);
			}
		} else {
			Log.info(value, info);
		}
	}

	// ************************************************************************ //
	// ************************************************************************ //
	// public helper

	/**
		helper method converting a given Callstack to a printable (multiline) string
	**/
	public static function formatCallstack(stack:Array<StackItem>, ?length:Int, ?seperator:String = "\n", ?startIndex:Int = 2):String {
		var result:String = "";

		if (length == null)
			length = stack.length;
		else
			length = Std.int(Math.min(startIndex + length, stack.length));

		//
		for (j in startIndex...length) {
			var index:Int = j;

			var item:String = stack[index].getParameters()[0];
			item = item.substr(6);

			result += item;

			if (index + 1 < length)
				result += seperator;
		}

		return result;
	}

	// ************************************************************************ //
	// ************************************************************************ //
	// logging

	/**
		trace( LogType.INFO, ... )
	**/
	inline public static function info(value:Dynamic, ?info:PosInfos):Dynamic {
		for (logger in Log.loggerList)
			logger.log(LogType.INFO, value, info);

		return value;
	}

	/**
		trace( LogType.WARNING, ... )
	**/
	inline public static function warn(value:Dynamic, ?info:PosInfos):Dynamic {
		for (logger in Log.loggerList)
			logger.log(LogType.WARNING, value, info);

		return value;
	}

	/**
		trace( LogType.ERROR, ... )
	**/
	inline public static function error(value:Dynamic, ?info:PosInfos):Dynamic {
		for (logger in Log.loggerList)
			logger.log(LogType.ERROR, value, info);

		return value;
	}

	/**
		trace( LogType.UNCAUGHT, ... )
	**/
	inline public static function uncaught(value:Dynamic, ?info:PosInfos):Dynamic {
		for (logger in Log.loggerList)
			logger.log(LogType.UNCAUGHT, value, info);

		return value;
	}
}
