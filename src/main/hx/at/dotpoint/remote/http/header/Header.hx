package hx.at.dotpoint.remote.http.header;

import hx.at.dotpoint.validation.Assert;
import hx.at.dotpoint.remote.http.header.property.Version;
import hx.at.dotpoint.remote.http.header.property.Host;
import haxe.ds.StringMap;

using StringTools;

/**
 *
 */
class Header extends StringMap<String> {
  //
  public function new() {
    super();
  }

  //
  public static function decode<T:Header>(input:String, output:T):T {
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
  public function encode():String {
    var result = new Array<String>();

    for (key in this.keys()) {
      result.push(key + ":" + this.get(key));
    }

    return result.join("\r\n");
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
