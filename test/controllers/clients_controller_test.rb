require 'test_helper'

class ClientsControllerTest < ActionDispatch::IntegrationTest

  test 'should get a list of users with GET /users' do
    get clients_url
    assert_response :success
    assert_equal response.content_type, 'application/json'
    clients = JSON.parse(response.body)
    assert_equal 3, clients.length
  end

  test 'should get a single user with GET /users/:id' do
    user = clients(:john)
    get client_path(user)
    assert_response :success
    assert_equal response.content_type, 'application/json'
    client = JSON.parse(response.body)
    assert_equal user['name'], client['name']
  end

  test 'should get status 404 with invalid id' do
    get client_path(id: 10)
    assert_response :missing
    client = JSON.parse(response.body)
    assert client.empty?
  end

end
