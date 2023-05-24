package hx.at.dotpoint.remote.http.url;

abstract Schema(String) from String to String {
  //
	inline public function new(i:String) {
		this = StringTools.trim(i).toLowerCase();
	}
}