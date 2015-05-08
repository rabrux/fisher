window.name = 'NG_DEFER_BOOTSTRAP!'

requirejs [
	'angular'
	'app'
	# 'cs!routes'
	'angular-route'
], (angular, app, ngRoute) ->

	$html = angular.element document.getElementsByTagName('html')[0]

	angular.element().ready( () ->
		angular.resumeBootstrap [app.name]
	)
