angular.module('app')
  .controller 'RenderCtrl', [
    '$scope'
    ($scope) ->

      $scope.$parent.child = $scope

      # $scope.Expression = '\\frac{5}{4} \\div \\frac{1}{6}'
      $scope.templates = {
        m: 'm_{/el/} = \\frac{1}{ /n/ } \\left( /class/ \\right) = \\left[\\begin{matrix} /m.x/ \\\\ /m.y/ \\end{matrix} \\right]'
        sp: 'S_{/n/} = /data/'
        sm: 'S_{/n/} = /matrix/'
        s: 'S_{/n/} = /matrix/'
        sw: 'S_{/n/} = /matrix/'
        swinv: 'S_{/n/}^{-1} = /matrix/'
        wp: 'W = /swm1/ \\left( /m1/ - /m2/ \\right)'
        wpr: 'W = /swm1/ /m12/'
        w: 'W = /w/'
      }

      $scope.Update = ->
        console.log 'update'
        math = MathJax.Hub.getAllJax("mathElement")[0]
        math.Text('\\left[\\begin{matrix} {{ m1.x }} \\\\ 2 \\end{matrix} \\right]')

      $scope.renderM = (Obj, m, element) ->
        el = element.substr(element.length - 1, 1)
        math = MathJax.Hub.getAllJax(element)[0]
        template = $scope.templates.m
        result = ''
        for item in Obj
          result += '\\left[\\begin{matrix} ' +  parseFloat(item.x).toFraction() + ' \\\\ ' +  parseFloat(item.y).toFraction() + ' \\end{matrix} \\right]+'

        result = result.substr(0, result.length - 1)

        template = String(template).replace(/\/el\//, el)
        template = String(template).replace(/\/class\//, result)
        template = String(template).replace(/\/n\//, Obj.length)
        template = String(template).replace(/\/m.x\//, m.x.toFraction())
        template = String(template).replace(/\/m.y\//, m.y.toFraction())

        math.Text template

        return

      $scope.renderSp = (sp, element) ->
        el       = element.substr(element.length - 1, 1)
        math     = MathJax.Hub.getAllJax(element)[0]
        template = $scope.templates.sp
        result   = ''
        for item in sp
          result += '\\left[ \\left[ \\begin{matrix} ' + item.x.toFraction() + ' \\\\ ' + item.y.toFraction() + ' \\end{matrix} \\right] \\left[ \\begin{matrix} ' + item.x.toFraction() + ' & ' + item.y.toFraction() + ' \\end{matrix} \\right] \\right]+'

        result = result.substr(0, result.length - 1) # Eliminar el último signo de adición

        template = String(template).replace(/\/data\//, result)
        template = String(template).replace(/\/n\//, el)

        math.Text template

        return

      $scope.renderSm = (sm, element) ->
        el   = element.substr(element.length - 1, 1)
        math = MathJax.Hub.getAllJax(element)[0]
        template = $scope.templates.sm
        result = ''
        for item in sm
          result += '\\left[ \\begin{matrix} ' + item.xx.toFraction() + ' & ' + item.xy.toFraction() + ' \\\\ ' + item.yx.toFraction() + ' & ' + item.yy.toFraction() + ' \\end{matrix} \\right]+'

        result = result.substr(0, result.length - 1) # Eliminar el último signo de adición

        template = String(template).replace(/\/matrix\//, result)
        template = String(template).replace(/\/n\//, el)

        math.Text template

      $scope.renderS = (s, element) ->
        el   = element.substr(element.length - 1, 1)
        math = MathJax.Hub.getAllJax(element)[0]
        template = $scope.templates.s

        result = '\\left[ \\begin{matrix} ' + s.xx.toFraction() + ' & ' + s.xy.toFraction() + ' \\\\ ' + s.yx.toFraction() + ' & ' + s.yy.toFraction() + ' \\end{matrix} \\right]'

        template = String(template).replace(/\/matrix\//, result)
        template = String(template).replace(/\/n\//, el)

        math.Text template

      $scope.renderSwf = (s1, s2, element) ->
        el   = element.substr(element.length - 1, 1)
        math = MathJax.Hub.getAllJax(element)[0]
        template = $scope.templates.sw
        result = '\\left[ \\begin{matrix} ' + s1.xx.toFraction() + ' & ' + s1.xy.toFraction() + ' \\\\ ' + s1.yx.toFraction() + ' & ' + s1.yy.toFraction() + ' \\end{matrix} \\right]+'
        result += '\\left[ \\begin{matrix} ' + s2.xx.toFraction() + ' & ' + s2.xy.toFraction() + ' \\\\ ' + s2.yx.toFraction() + ' & ' + s2.yy.toFraction() + ' \\end{matrix} \\right]'

        template = String(template).replace(/\/matrix\//, result)
        template = String(template).replace(/\/n\//, el)

        math.Text template

        return

      $scope.renderSw = (sw, element, inv) ->
        el   = element.substr(element.length - 1, 1)
        math = MathJax.Hub.getAllJax(element)[0]
        if inv
          template = $scope.templates.swinv
        else
          template = $scope.templates.sw

        result = '\\left[ \\begin{matrix} ' + sw[0][0].toFraction() + ' & ' + sw[0][1].toFraction() + ' \\\\ ' + sw[1][0].toFraction() + ' & ' + sw[1][1].toFraction() + ' \\end{matrix} \\right]'

        template = String(template).replace(/\/matrix\//, result)
        template = String(template).replace(/\/n\//, el)

        math.Text template

        return

      $scope.renderWp = (swm1, m1, m2, element) ->
        math = MathJax.Hub.getAllJax(element)[0]
        template = $scope.templates.wp

        result = '\\left[ \\begin{matrix} ' + swm1[0][0].toFraction() + ' & ' + swm1[0][1].toFraction() + ' \\\\ ' + swm1[1][0].toFraction() + ' & ' + swm1[1][1].toFraction() + ' \\end{matrix} \\right]'
        template = String(template).replace(/\/swm1\//, result)

        result = '\\left[ \\begin{matrix} ' + m1.x.toFraction() + ' \\\\ ' + m1.y.toFraction() + ' \\end{matrix} \\right]'
        template = String(template).replace(/\/m1\//, result)

        result = '\\left[ \\begin{matrix} ' + m2.x.toFraction() + ' \\\\ ' + m2.y.toFraction() + ' \\end{matrix} \\right]'
        template = String(template).replace(/\/m2\//, result)

        math.Text template

      $scope.renderWpr = (swm1,m12, element) ->
        math = MathJax.Hub.getAllJax(element)[0]
        template = $scope.templates.wpr

        result = '\\left[ \\begin{matrix} ' + swm1[0][0].toFraction() + ' & ' + swm1[0][1].toFraction() + ' \\\\ ' + swm1[1][0].toFraction() + ' & ' + swm1[1][1].toFraction() + ' \\end{matrix} \\right]'
        template = String(template).replace(/\/swm1\//, result)

        result = '\\left[ \\begin{matrix} ' + m12.x.toFraction() + ' \\\\ ' + m12.y.toFraction() + ' \\end{matrix} \\right]'
        template = String(template).replace(/\/m12\//, result)

        math.Text template

      $scope.renderW = (w, element) ->
        math = MathJax.Hub.getAllJax(element)[0]
        template = $scope.templates.w

        result = '\\left[ \\begin{matrix} ' + w[0].toFraction() + '\\\\' + w[1].toFraction() + ' \\end{matrix} \\right]'
        template = String(template).replace(/\/w\//, result)

        math.Text template

      $scope.renderY = (y, element) ->
        math = MathJax.Hub.getAllJax(element)[0]
        result = ''
        i = 0
        while i < y.length
          result += 'y_{' + parseInt(i + 1) + '} = ' + y[i].toFraction() + ' \\\\ '
          i++

        math.Text result

      return
  ]

Number.prototype.toFraction = ->
  value = @.valueOf()
  f = new Fraction(value)
  if f.d != 1
    if f.s > 0
      return '\\frac{' + f.n + '}{' + f.d + '}'
    else
      return '-\\frac{' + f.n + '}{' + f.d + '}'
  else
    return f.s * f.n
