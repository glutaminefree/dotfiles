var INFO = xml`
<plugin name="set-dev-cookie" version="0.01"
		href="http://ororo.ru"
		summary="Set cookie with name dev"
		lang="en_US"
		xmlns="http://vimperator.org/namespaces/liberator">
	<author email="glutaminefree@mail.ru">glutaminefree</author>
	<project name="Vimperator" minVersion="3.10.1"/>
	<license>MIT style license</license>
	<p>Set cookie with name dev.</p>
</plugin>`;

function CookieManager() {
	this.initialize.apply(this, arguments);
}
CookieManager.prototype = {
	initialize: function (uri) {
		const Cc = Components.classes;
		const Ci = Components.interfaces;

		const MOZILLA = '@mozilla.org/';
		const IO_SERVICE = MOZILLA + 'network/io-service;1';
		const COOKIE_SERVICE = MOZILLA + 'cookieService;1';

		this.ioService = Cc[IO_SERVICE].getService(Ci.nsIIOService);
		this.cookieService = Cc[COOKIE_SERVICE].getService(Ci.nsICookieService);
		if(!this.ioService || !this.cookieService) {
			throw new Error('error on CookieManager initialize.');
		}

		this.readCookie(uri);
	},

	readCookie: function (uri) {
		if(uri) {
			this.uri = uri;
			this.uriObject = this.ioService.newURI(uri, null, null);
			this.cookie = this._deserializeCookie(this._getCookieString());
		}
	},

	_getCookieString: function () {
		return this.uriObject
			? this.cookieService.getCookieString(this.uriObject, null)
			: null;
	},

	_setCookieString: function (cookieString) {
		if(this.uriObject && cookieString) {
			this.cookieService.setCookieString(this.uriObject, null, cookieString, null);
		}
	},

	_deserializeCookie: function (cookieString) {
		var cookies = cookieString.split('; ');
		var cookie = {};
		var key, val;
		for (let i=0, max=cookies.length ; i<max ; ++i) {
			[key, val] = cookies[i].split('=');
			cookie[key] = val;
		}
		return cookie;
	},

	getCookie: function (key) {
		return this.cookie[key] ? this.cookie[key] : null;
	},

	setCookie: function (obj) {
		this.cookie[obj.key] = obj.value;
		var string = [
			obj.key + '=' + obj.value,
			'domain=' + obj.domain,
			'expires=' + new Date(new Date().getTime() + obj.expires),
		].join(';');
		this._setCookieString(string);
	},
}; 

commands.addUserCommand(['setdevcookie', 'sdc'], 'Set dev cookie', function(args){
	let cookieManager = new CookieManager(); 
	cookieManager.setCookie({
		key: 'dev',
		value: true,
		expires: 0,
		domain: '/'
	});
});
