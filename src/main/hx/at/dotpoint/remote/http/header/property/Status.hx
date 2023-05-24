package hx.at.dotpoint.remote.http.header.property;

/**
	"100"  ; Section 10.1.1: Continue
	"101"  ; Section 10.1.2: Switching Protocols
	"200"  ; Section 10.2.1: OK
  .. etc
 */
abstract Status(Int) from Int to Int {
	// 2xx:
	public static var OK(default, never) = new Status(200);

	// 4xx:
	public static var BAD_REQUEST(default, never)             = new Status(400);
	public static var NOT_FOUND(default, never)               = new Status(404);
	public static var UNSUPPORTED_MEDIA_TYPE(default, never)  = new Status(415);

	// 5xx:
	public static var INTERNAL_SERVER_ERROR(default, never)   = new Status(500);
	public static var NOT_IMPLEMENTED(default, never)         = new Status(501);

	// ************************************************************************ //
	// ************************************************************************ //
	// Constructor

	//
	inline public function new(i:Int) {
		this = i;
	}

	//
	@to
	public function toString():String {
		var i:Int = this;

		switch (i) {
			// 2xx:
			case 200:
				return '$i OK';

			// 4xx:
			case 400:
				return '$i Bad Request';
			case 404:
				return '$i Not Found';
			case 415:
				return '$i Unsupported Media Type';

			// 5xx:
			case 500:
				return '$i Internal Server Error';
			case 501:
				return '$i Not Implemented';

			default:
				return '$i';
		}
	}
}
