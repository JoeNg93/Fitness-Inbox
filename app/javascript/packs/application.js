/* eslint no-console:0 */
// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.
//
// To reference this file, add <%= javascript_pack_tag 'application' %> to the appropriate
// layout file, like app/views/layouts/application.html.erb

import 'angular'
import 'angular-ui-router'
import homeCtrl from './../home/home_ctrl';
import loginCtrl from './../login/login_ctrl';
import signupCtrl from './../signup/signup_ctrl';
import chatCtrl from './../chat/chat_ctrl';
import newMessageCtrl from './../new_message/new_message_ctrl';
import userState from './../services/user';

const myApp = angular.module('myApp', ['ui.router']);

myApp.config(['$stateProvider', '$locationProvider', '$urlRouterProvider',
  function ($stateProvider, $locationProvider, $urlRouterProvider) {
    $locationProvider.html5Mode(true);

    $stateProvider.state('home', {
      url: '/',
      templateUrl: 'home/home.html',
      controller: 'homeCtrl'
    });

    $stateProvider.state('login', {
      url: '/login',
      templateUrl: 'login/login.html',
      controller: 'loginCtrl'
    });

    $stateProvider.state('signup', {
      url: '/signup',
      templateUrl: 'signup/signup.html',
      controller: 'signupCtrl'
    });

    $stateProvider.state('chat', {
      url: '/chat',
      templateUrl: 'chat/chat.html',
      controller: 'chatCtrl'
    });

    $stateProvider.state('new_message', {
      url: '/message/new',
      templateUrl: 'message/new_message.html',
      controller: 'newMessageCtrl'
    });

    $urlRouterProvider.otherwise('/');

  }]);

myApp.controller('navBarCtrl', ['userState', '$scope', '$http', '$state', function (userState, $scope, $http, $state) {
  $scope.$on('User authenticated', function (event, args) {
    $scope.user = userState.currentUser;
  });

  $scope.signout = function () {
    $http.post('/logout').then(() => {
      userState.currentUser = null;
      $scope.user = null;
      $state.is('home') ? $state.reload() : $state.go('home');
    });
  };
}]);

myApp.controller('homeCtrl',  homeCtrl);
myApp.controller('loginCtrl', loginCtrl);
myApp.controller('signupCtrl', signupCtrl);
myApp.controller('chatCtrl', chatCtrl);
myApp.controller('newMessageCtrl', newMessageCtrl);

myApp.factory('userState', userState);