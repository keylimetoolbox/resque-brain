controllers = angular.module('controllers')
controllers.controller("SummaryController", [
  '$scope', 'Resques', "GenericErrorHandling",
  ($scope ,  Resques ,  GenericErrorHandling)->

    $scope.loading             = true
    $scope.allResques          = []
    $scope.totalFailed         = 0
    $scope.totalRunning        = 0
    $scope.totalRunningTooLong = 0
    $scope.totalWaiting        = 0

    setResquesAndDeriveTotals = (resques)->
      sumField = (list,field)->
        _.chain(list).pluck(field).reduce((acc,val)-> acc + val).value()

      $scope.allResques   = resques
      $scope.totalFailed  = sumField(resques,"failed")
      $scope.totalRunning = sumField(resques,"running")
      $scope.totalWaiting = sumField(resques,"waiting")
      $scope.loading      = false

    Resques.summary(
      setResquesAndDeriveTotals,
      GenericErrorHandling.onFail($scope)
    )

])
