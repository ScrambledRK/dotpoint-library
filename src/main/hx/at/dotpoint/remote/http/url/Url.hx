package hx.at.dotpoint.remote.http.url;

/**
  TODO: url implementation

  http://example.com/foo/bar
  mailto:bla@foo?blub=Hello
**/
abstract Url(String) from String to String { 
	// public var protocol(get, never):Schema;
	// public var authority(get, never):Int;
}