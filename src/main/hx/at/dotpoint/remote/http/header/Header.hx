package hx.at.dotpoint.remote.http.header;

import hx.at.dotpoint.remote.http.header.property.Protocol;
import hx.at.dotpoint.remote.http.header.property.Host;
import haxe.ds.StringMap;

using StringTools;

/**
 *
 */
class Header extends StringMap<String> {
	public var host(get, set):Host;
	public var protocol(get, set):Protocol;

	// ************************************************************************ //
	// ************************************************************************ //
	// Constructor

	//
	public function new() {
		super();
	}
	
	//
	public static function decode(input:String, ?output:Header):Header {
		if (output == null)
			output = new Header();

		//
		var lines:Array<String> = input.split("\r\n");

		for (line in lines) {
			var idxColon:Int = line.indexOf(":");

			var param:String = line.substring(0, idxColon).trim();
			var value:String = line.substring(idxColon + 1).trim();

			//
			output.set(param, value);
		}

		return output;
	}

	//
	public static function encode(input:Header):String {
		var result = new Array<String>();

		for (key in input.keys()) {
			result.push(key + ":" + input.get(key));
		}

		return result.join("\r\n");
	}

	// ************************************************************************ //
	// ************************************************************************ //
	// getter / setter

	//
	inline private function get_host():Host {
		return this.getValue("host", Host.new);
	}

	inline private function set_host(value:Host):Host {
		return this.setValue("host", value);
	}

	//
	inline private function get_protocol():Protocol {
		return this.getValue("protocol", Protocol.new);
	}

	inline private function set_protocol(value:Protocol):Protocol {
		return this.setValue("protocol", value);
	}

	// ************************************************************************ //
	// Methods
	// ************************************************************************ //

	//
	@:generic inline private function setValue<T>(key:String, value:T):T {
		if (value != null) {
			this.set(key, Std.string(value));
		} else {
			this.remove(key);
		}

		return value;
	}

	//
	@:generic inline private function getValue<T>(key:String, transform:String->T):T {
		var value:String = this.get(key);

		if (value == null)
			return null;

		return transform(value);
	}

	//
	@:generic inline private function setArray<T>(key:String, value:Array<T>):Array<T> {
		if (value != null && value.length > 0) {
			var result:String = "";

			for (v in value)
				result += v + ",";

			this.set(key, result.substring(0, result.length - 1));
		} else {
			this.remove(key);
		}

		return value;
	}

	//
	@:generic inline private function getArray<T>(key:String, transform:String->T):Array<T> {
		var value:String = this.get(key);

		if (value != null && value.length > 0) {
			var result:Array<T> = new Array<T>();

			for (type in value.split(","))
				result.push(transform(type));

			return result;
		}

		return null;
	}
}
