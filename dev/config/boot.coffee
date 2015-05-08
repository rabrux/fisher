window.name = 'NG_DEFER_BOOTSTRAP!'

requirejs [
  'angular'
  'app'
  'uiRouter'
], (angular, app, uiRouter) ->
  $html = undefined
  $html = angular.element(document.getElementsByTagName('html')[0])
  angular.element().ready ->
    angular.resumeBootstrap [ app.name ]