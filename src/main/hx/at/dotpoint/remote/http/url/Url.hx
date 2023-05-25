package hx.at.dotpoint.remote.http.url;

/**
  TODO: url implementation

  http://example.com/foo/bar
  mailto:bla@foo?blub=Hello
**/
abstract Url(String) from String to String { 
	// public var protocol(get, never):Schema;
	// public var authority(get, never):Int;

  public var path(get, never):String;
	public var parameters(get, never):Parameters;

	//
	private inline function get_path():String {
		return this.substring(0,this.indexOf("?"));
	}

	//
	private inline function get_parameters():Parameters {
		return new Parameters(this);
	}
}