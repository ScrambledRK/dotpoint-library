package hx.at.dotpoint.remote.http.header.property;

/**
 * 
 */
abstract LanguageType(String) from String to String {
	//
	inline public function new(i:String) {
		this = StringTools.trim(i).toLowerCase();
	}
}
