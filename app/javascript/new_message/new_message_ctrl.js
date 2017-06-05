const newMessageCtrl = ['$scope', '$http', '$state', 'userState', function ($scope, $http, $state, userState) {
  $scope.receivers = [];
  $scope.user = userState.currentUser;

  if (!$scope.user) {
    $http.get('/authenticate')
      .then((response) => {
        $http.get('/api/clients')
          .then((response) => {
            $scope.receivers = response.data.filter(client => client.id !== userState.currentUser.id);
          });
      })
      .catch((err) => {
        $state.go('home');
      });
  } else {
    $http.get('/api/clients')
      .then((response) => {
        $scope.receivers = response.data.filter(client => client.id !== userState.currentUser.id);
      });
  }

  $scope.addNewMessage = function (message) {
    if ($scope.newMessageForm.$valid) {
      message.sender_id = userState.currentUser.id;
      $http.post('/api/messages', message)
        .then((response) => {
          userState.currentChatter = $scope.receivers.filter(receiver => receiver.id == message.receiver_id)[0];
          console.log(userState.currentChatter);
          $state.go('chat');
        });
    }
  };
}];

export default newMessageCtrl;