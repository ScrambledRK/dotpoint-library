package hx.at.dotpoint.remote.http.header;

import hx.at.dotpoint.remote.http.header.property.Accept;
import hx.at.dotpoint.remote.http.header.property.EncodingType;
import hx.at.dotpoint.remote.http.header.property.LanguageType;

/**
	GET / HTTP/1.1
	Host: www.newhere.org
	Connection: keep-alive
	Pragma: no-cache
	Cache-Control: no-cache
	Upgrade-Insecure-Requests: 1
	User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/64.0.3282.186
	Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*|*;q=0.8
	Accept-Encoding: gzip, deflate, br
	Accept-Language: en-US, en;q=0.9
	Cookie: XDEBUG_SESSION=PHPSTORM
 */
class RequestHeader extends Header {
	public var accept(get, set):Array<Accept>;
	public var acceptEncoding(get, set):Array<EncodingType>;
	public var acceptLanguage(get, set):Array<LanguageType>;

	//
	public function new() {
		super();
	}

	// ************************************************************************ //
	// ************************************************************************ //
	// Methods

	//
	inline private function get_accept():Array<Accept> {
		return getArray("accept", Accept.new);
	}

	inline private function set_accept(value:Array<Accept>):Array<Accept> {
		return this.setArray("accept", value);
	}

	//
	inline private function get_acceptEncoding():Array<EncodingType> {
		return getArray("accept-encoding", EncodingType.new);
	}

	inline private function set_acceptEncoding(value:Array<EncodingType>):Array<EncodingType> {
		return setArray("accept-encoding", value);
	}

	//
	inline private function get_acceptLanguage():Array<LanguageType> {
		return getArray("accept-language", LanguageType.new);
	}

	inline private function set_acceptLanguage(value:Array<LanguageType>):Array<LanguageType> {
		return setArray("accept-language", value);
	}
}
