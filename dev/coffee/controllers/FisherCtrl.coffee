angular.module('app')
  .controller 'FisherCtrl', [
    '$scope'
    '$element'
    ($scope, $element) ->

      $scope.child = {}

      $scope.model1 =
        x: 0
        y: 0

      $scope.model2 =
        x: 0
        y: 0

      $scope.classOne = []
      $scope.classOne = [
        { x: 1, y: 3 }
        { x: 2, y: 2 }
        { x: 3, y: 3 }
      ]
      $scope.classTwo = []
      $scope.classTwo = [
        { x: 2, y: 6 }
        { x: 3, y: 5 }
        { x: 4, y: 5 }
      ]

      $scope.add = (classObj, model) ->
        classObj.push {x: model.x, y: model.y}
        return

      $scope.remove = (classObj, index) ->
        classObj.splice index, 1
        return

      $scope.update = (classObj, index, value) ->
        console.log value
        console.log classObj
        console.log index
        return

      $scope.calculate = ->
        m1 = { x: 0, y: 0 }
        m2 = { x: 0, y: 0 }
        m12 = { x: 0, y: 0 }
        sum1 = { x: 0, y: 0 }
        sum2 = { x: 0, y: 0 }
        $scope.m1 = m1 = { x: 0, y: 0 }
        $scope.m2 = m2 = { x: 0, y: 0 }
        $scope.S1p = S1p = []
        $scope.S2p = S2p = []
        S1m = []
        S2m = []
        S1 = { xx: 0, xy: 0, yx: 0, yy: 0 }
        S2 = { xx: 0, xy: 0, yx: 0, yy: 0 }
        Sw_ = [
          [ 0, 0 ]
          [ 0, 0 ]
        ]
        Sw = [
          [ 0, 0 ]
          [ 0, 0 ]
        ]
        Swm1 = [
          [ 1, 0 ]
          [ 0, 1 ]
        ]
        W = [
          [ 0, 0 ]
          [ 0, 0 ]
        ]
        Y = []
        # Sw = [
        #   { xx: 0, xy: 0, yx: 0, yy: 0 }
        #   { gxx: 0, gxy: 0, gyx: 0, gyy: 0 }
        # ]
        # Suma de los valores de la clase 1
        for item in $scope.classOne
          sum1.x += parseInt(item.x)
          sum1.y += parseInt(item.y)

        # Suma de los valores de la clase 2
        for item in $scope.classTwo
          sum2.x += parseInt(item.x)
          sum2.y += parseInt(item.y)

        # Calculando m1
        m1.x = (1 / $scope.classOne.length) * sum1.x
        m1.y = (1 / $scope.classOne.length) * sum1.y

        # Calculando m2
        m2.x = (1 / $scope.classTwo.length) * sum2.x
        m2.y = (1 / $scope.classTwo.length) * sum2.y

        # Calculando S1
        for item in $scope.classOne
          S1p.push { x: m1.x - item.x, y: m1.y - item.y }

        # Calculando S2
        for item in $scope.classTwo
          S2p.push { x: m2.x - item.x, y: m2.y - item.y }

        # Generación de matrices S1
        for item in S1p
          S1m.push { xx: item.x * item.x, xy: item.x * item.y, yx: item.y * item.x, yy: item.y * item.y }

        # Generación de matrices S2
        for item in S2p
          S2m.push { xx: item.x * item.x, xy: item.x * item.y, yx: item.y * item.x, yy: item.y * item.y }

        # console.log 'S1m', S1m
        # console.log 'S2m', S2m

        # Cálculo de S1
        for item in S1m
          S1.xx += item.xx
          S1.xy += item.xy
          S1.yx += item.yx
          S1.yy += item.yy

        # Cálculo de S2
        for item in S2m
          S2.xx += item.xx
          S2.xy += item.xy
          S2.yx += item.yx
          S2.yy += item.yy

        # console.log 's1', S1
        # console.log 's2', S2

        # Cálculo SW
        Sw[0][0] = S1.xx + S2.xx
        Sw[0][1] = S1.xy + S2.xy
        Sw[1][0] = S1.yx + S2.yx
        Sw[1][1] = S1.yy + S2.yy



        a = 0
        while a < Sw.length
          b = 0
          while b < Sw.length
            Sw_[a][b] = Sw[a][b]
            b++
          a++

        # Cálculo inversa de SW
        i = 0
        while i < Sw.length
          j = 0
          while j < Sw.length
            if i == j
              factor = Sw[i][j]
              m = 0
              while m < Sw.length # Multiplicamos toda la fila por el factor
                Sw[i][m] *= 1 / factor
                Swm1[i][m] *= 1 / factor # Matriz resultado
                m++
              z = 0
              while z < Sw.length
                fac = Sw[z][i]
                if i != z
                  r = 0
                  while r < Sw.length
                    pib = Sw[i][r]
                    ren = Sw[z][r]
                    pib_1 = Swm1[i][r]
                    ren_1 = Swm1[z][r]
                    Sw[z][r] = -fac * pib + ren
                    Swm1[z][r] = -fac * pib_1 + ren_1
                    r++
                z++
            j++
          i++

        # Cálculo de (m1 - m2)
        m12.x = m1.x - m2.x
        m12.y = m1.y - m2.y

        # Cálculo W
        W = [
          Swm1[0][0] * m12.x + Swm1[0][1] * m12.y
          Swm1[1][0] * m12.x + Swm1[1][1] * m12.y
        ]

        # Cálculo de Ys
        for item in $scope.classOne
          Y.push W[0] * item.x + W[1] * item.y

        for item in $scope.classTwo
          Y.push W[0] * item.x + W[1] * item.y

        $scope.Y = Y

        # Render M
        $scope.child.renderM($scope.classOne, m1, 'math-m1')
        $scope.child.renderM($scope.classTwo, m2, 'math-m2')

        # Render Sp
        $scope.child.renderSp(S1p, 'math-sp1')
        $scope.child.renderSp(S2p, 'math-sp2')

        # Render Sm
        $scope.child.renderSm(S1m, 'math-sm1')
        $scope.child.renderSm(S2m, 'math-sm2')

        # Render S matriz resultado
        $scope.child.renderS(S1, 'math-s1')
        $scope.child.renderS(S2, 'math-s2')

        # Render Sw
        $scope.child.renderSwf(S1, S2, 'math-swpw')
        $scope.child.renderSw(Sw_, 'math-sw')

        # Render Sw^-1
        $scope.child.renderSw(Swm1, 'math-swm1w', true)

        # Render W Sustitución
        $scope.child.renderWp(Swm1, m1, m2, 'math-wp')

        # Render W paso 1
        $scope.child.renderWpr(Swm1, m12, 'math-wpr')

        # Render W resultado
        $scope.child.renderW(W, 'math-w')

        # Render Ys
        $scope.child.renderY(Y, 'math-y')

        $scope.isCalculate = true

        return

      return
  ]
