requirejs ['angular', 'uiRouter'], (ng) ->

  return ng
    .module('app')
    .config [
	    '$stateProvider'
	    '$urlRouterProvider'
	    ($stateProvider, $urlRouterProvider) ->

	      $urlRouterProvider.otherwise '/'

	      $stateProvider
	        .state('index',
            url: '/'
            templateUrl: 'templates/home/index.html'
            controller: 'HomeCtrl'
          )

	      return
	  ]
