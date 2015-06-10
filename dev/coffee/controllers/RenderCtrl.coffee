angular.module('app')
  .controller 'RenderCtrl', [
    '$scope'
    ($scope) ->

      $scope.$parent.child = $scope

      # $scope.Expression = '\\frac{5}{4} \\div \\frac{1}{6}'
      $scope.templates = {
        m: 'm1 = \\frac{1}{ /n/ } \\left( /class/ \\right) = \\left[\\begin{matrix} /m.x/ \\\\ /m.y/ \\end{matrix} \\right]'
      }

      $scope.Update = ->
        console.log 'update'
        math = MathJax.Hub.getAllJax("mathElement")[0]
        math.Text('\\left[\\begin{matrix} {{ m1.x }} \\\\ 2 \\end{matrix} \\right]')

      $scope.renderM = (Obj, m, element) ->
        math = MathJax.Hub.getAllJax(element)[0]
        template = $scope.templates.m
        result = ''
        for item in Obj
          result += '\\left[\\begin{matrix} ' + item.x + ' \\\\ ' + item.y + ' \\end{matrix} \\right]+'

        result = result.substr(0, result.length - 1)

        template = String(template).replace(/\/class\//, result)
        template = String(template).replace(/\/n\//, Obj.length)
        template = String(template).replace(/\/m.x\//, m.x)
        template = String(template).replace(/\/m.y\//, m.y)

        math.Text template

        return

      return
  ]
