// Globals
// var TEMPLATE_DIR = "src/coffee/views";
// var BLOG_URI = 'http://blog.cryndi.org/';

require.config({
	baseUrl: "app",
	paths: {
		'angular': '../lib/angular/angular.min',
		'angular-route': '../lib/angular-route/angular-route',
		'reCaptcha': '../lib/angular-recaptcha/release/angular-recaptcha.min',
		'cs': '../lib/require-cs/cs',
		'coffee-script': '../lib/coffeescript/extras/coffee-script',
		'app': 'app.min',
		//'routes': 'routes',
		//'appBoot': '../config/bootstrap'
	},
	shim: {
		'angular': { 'exports': 'angular' },
		'angular-route': ['angular'],
		'reCaptcha': ['angular']
	}
});

requirejs(['app']);
//requirejs(['cs!appBoot']);
