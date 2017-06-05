const signupCtrl = ['$scope', '$http', '$state', function ($scope, $http, $state) {
  $scope.signup = function (client) {
    if ($scope.client.password !== $scope.client.password_confirmation) {
      $scope.signupForm.$error.signup_error= 'Password confirmation doesnt not match';
      $state.go('signup');
    }
    if ($scope.signupForm.$valid) {
      $http.post('/api/clients', { client: client })
        .then((response) => {
          console.log(response);
          $state.go('home');
        })
        .catch((err) => {
          $scope.signupForm.$error.signup_error = err.data.error;
          $state.go('signup');
        })
    }
  };
}];

export default signupCtrl;