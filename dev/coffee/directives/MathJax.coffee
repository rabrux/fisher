angular.module('app')
  .directive 'mathjaxBind', ->
    {
      restrict: 'A'
      controller: [
        '$scope'
        '$element'
        '$attrs'
        ($scope, $element, $attrs) ->
          $scope.$watch $attrs.mathjaxBind, (value) ->
            console.log value
            $element.html value
            MathJax.Hub.Update()
            return
          MathJax.Hub.Update()
          return
      ]
    }
