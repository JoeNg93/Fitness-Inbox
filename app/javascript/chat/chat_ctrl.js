import _ from 'lodash';

const chatCtrl = ['$scope', '$http', '$state', 'userState', '$rootScope', function ($scope, $http, $state, userState, $rootScope) {
  $scope.user = userState.currentUser;
  $scope.chatters = [];

  if (!$scope.user) {
    $http.get('/authenticate')
      .then((response) => {
        $scope.user = response.data;
        userState.currentUser = $scope.user;
        $rootScope.$broadcast('User authenticated');
        $http.get(`/api/clients/${userState.currentUser.id}/messages`)
          .then((response) => {
            $scope.messages = response.data;
            let current_user_id = userState.currentUser.id;
            $scope.chatters = getChattersOf(current_user_id, $scope.messages);
          });
      })
      .catch((err) => {
        $state.go('home');
      });
  } else {
    $http.get(`/api/clients/${userState.currentUser.id}/messages`)
      .then((response) => {
        $scope.messages = response.data;
        let current_user_id = userState.currentUser.id;
        $scope.chatters = getChattersOf(current_user_id, $scope.messages);
        userState.currentChatter && $scope.getConversationWith(userState.currentChatter);
        userState.currentChatter = null;
      });

  }

  $scope.hasUnreadMessagesWith = function (chatter) {
    return userState.currentUser.unread_messages.map(message => message.sender_id).indexOf(chatter.id) !== -1;
  };

  $scope.numOfUnreadMessagesWith = function (chatter) {
    return userState.currentUser.unread_messages.map(message => message.sender_id).filter(id => id === chatter.id).length;
  };

  $scope.getConversationWith = function (chatter) {
    $scope.markMessagesAsReadWith(chatter);
    $scope.currentConversation = $scope.messages.filter(message => message.sender_id === chatter.id || message.receiver_id === chatter.id);
    $scope.chatter = chatter;
  };

  $scope.markMessagesAsReadWith = function (chatter) {
    $http.post(`/api/clients/${$scope.user.id}/markread`, { sender_id: chatter.id })
      .then((response) => {
        $scope.user.unread_messages = response.data.unread_messages;
      });
  };

}];

function getChattersOf(user_id, messages) {
  let sendersOfEachMessage = messages.map(message => message.sender);
  let receiversOfEachMessage = messages.map(message => message.receiver);
  return _.uniqBy(sendersOfEachMessage.concat(receiversOfEachMessage), 'id').filter(sender => sender.id !== user_id);
}

export default chatCtrl;