const loginCtrl = ['$scope', '$http', '$state', function ($scope, $http, $state) {
  $scope.login = function (client) {
    if ($scope.loginForm.$valid) {
      $http.post('/login', { client: client })
        .then((response) => {
          $state.go('home');
        })
        .catch((err) => {
          $scope.loginForm.$error.authentication = err.data.error;
          $state.go('login');
        });
    }
  }
}];

export default loginCtrl;