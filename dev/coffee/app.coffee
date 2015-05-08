define ['angular'], (angular) ->

	return angular
		.module('app', ['ui.router'])
		.run ($rootScope, $templateCache) ->
			$rootScope.$on '$viewContentLoader', () ->
				$templateCache.removeAll
