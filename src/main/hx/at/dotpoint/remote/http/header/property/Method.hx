package hx.at.dotpoint.remote.http.header.property;

/**
 * 
 */
enum abstract Method(String) from String to String {
	var DELETE;
	var GET;
	var HEAD;
	var OPTIONS;
	var POST;
	var PUT;
}
