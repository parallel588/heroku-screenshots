var page = new WebPage();
var fs   = require('fs');
var system = require('system');

page.viewportSize = { width: 1600, height: 1200 };
var page_url = system.args[1];
var screenshoot_path = system.args[2];

page.onLoadFinished = function (status) {
	if (status !== 'success') {
		phantom.exit(1);
	}
	page.render(screenshoot_path);
	phantom.exit();
}

page.open(page_url);
