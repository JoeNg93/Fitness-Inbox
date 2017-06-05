import _ from 'lodash';

const homeCtrl = ['$scope', '$http', '$state', 'userState', '$rootScope', function ($scope, $http, $state, userState, $rootScope) {
  $scope.user = userState.currentUser;
  if (!$scope.user) {
    $http.get('/authenticate')
      .then((response) => {
        $scope.user = response.data;
        userState.currentUser = $scope.user;
        $rootScope.$broadcast('User authenticated');
        console.log(_.groupBy($scope.user.unread_messages, 'content'));
      })
      .catch((err) => {
        console.log(err);
      });
  }

}];

export default homeCtrl;