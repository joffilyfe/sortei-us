var tweetApp = angular.module('tweetApp', []);

tweetApp.controller('ReTweetCtrl', function ($scope, $http) {
  $http.get('/twitter/callback').success(function(data) {
    $scope.data = data;
  });

  $scope.dice = function(max) {
    var result = function(max) {
      var min = 1;
      return (Math.floor(Math.random() * (max - min + 1)) + min);
    }
    
    $scope.winner = result(max);
  }
});

