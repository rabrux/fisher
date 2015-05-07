# define ['app'], (app) ->
#
# 	# app.config ['$httpProvider', ($httpProvider) ->
# 	# 	console.log $httpProvider
# 	# 	$httpProvider.defaults.useXDomain = true
# 	# 	delete $httpProvider.defaults.headers.common['X-Requested-With']
# 	# ]
#
# 	app.config ['$routeProvider', ($routeProvider) ->
# 		$routeProvider
# 			.when('/',
# 				templateUrl: TEMPLATE_DIR + '/home/home.html',
# 				controller: 'SiteCtrl'
# 			)
# 			.when('/about-us',
# 				templateUrl: TEMPLATE_DIR + '/about/about-us.html',
# 				controller: 'SiteCtrl'
# 			)
# 			.when('/contact',
# 				templateUrl: TEMPLATE_DIR + '/contact/contact.html',
# 				controller: 'SiteCtrl'
# 			)
# 			.when('/quote',
# 				templateUrl: TEMPLATE_DIR + '/quote/quote.html',
# 				controller: 'SiteCtrl'
# 			)
# 			.when('/products',
# 				templateUrl: TEMPLATE_DIR + '/products/index.html',
# 				controller: 'ProductsCtrl'
# 			)
# 			.when('/products/category/:id',
# 				templateUrl: TEMPLATE_DIR + '/products/index.html',
# 				controller: 'ProductsCtrl'
# 			)
# 			.otherwise(
# 				redirectTo: '/'
# 			)
# 	]
