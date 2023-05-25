package hx.at.dotpoint.remote.http.url;

import haxe.ds.StringMap;

using StringTools;

/**
 * url parameters like: bla?foo=bar&bar=foo
 */
class Parameters extends StringMap<String> {
	//
	public function new(?input:String) {
		super();

		if(input != null){
			Parameters.decode(input,this);
		}
	}

	//
	public static function decode<T:Parameters>(input:String, output:T):Parameters {
		var idxStart = input.indexOf("?") + 1;

		if (idxStart == 0)
			return output;

		while (idxStart < input.length) {
			var idxEqual 		 = input.indexOf("=", idxStart);
			var idxDelimiter = input.indexOf("&", idxStart);

			if (idxEqual == -1)
				throw "invalid request parameter: missing '=' delimiter near index: " + idxStart + " in \n" + input;

			if (idxDelimiter == -1)
				idxDelimiter = input.length;

			//
			var param:String = input.substring(idxStart, idxEqual);
			var value:String = input.substring(idxEqual + 1, idxDelimiter);
					value = value.urlDecode();

			output.set(param, value);

			idxStart = idxDelimiter + 1;
		}

		//
		return output;
	}

	//
	public function encode():String {
		var result:String = "";

		for (key in this.keys()) {
			var value:String = this.get(key);
					value = value.urlEncode();

			result += key + "=" + value + "&";
		}

		return result.substr(0, result.length - 1);
	}
}
