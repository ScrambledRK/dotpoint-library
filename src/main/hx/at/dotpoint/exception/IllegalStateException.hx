package hx.at.dotpoint.exception;

import haxe.PosInfos;
import haxe.Exception;
import haxe.ValueException;

class IllegalStateException extends ValueException{
  public function new(state:String, ?message:String, ?previous:Exception, ?pos:PosInfos):Void {
		super(message == null ? 'IllegalState: "$state"' : message, previous, pos);
	}
}