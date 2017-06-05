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
    assert_equal response.content_type, 'application/json'
    client = JSON.parse(response.body)
    assert_not client['error'].nil?
  end

  test 'should post a user successfully with valid params' do
    client = { name: 'Peter', email: 'peter@example.com', role: 'trainer', password: 'foobar', password_confirmation: 'foobar' }
    assert_difference 'Client.count', 1 do
      post clients_url, params: { client: client }
    end
    assert_response :success
    assert_equal response.content_type, 'application/json'
    client_response = JSON.parse(response.body)
    assert_equal client[:email], client_response['email']
  end

  test 'should response with status 400 when posting a user with invalid params' do
    client = { name: 'Peter', email: 'peter@example.com', role: 'trainer', password: 'foobar', password_confirmation: 'foobar' }
    assert_no_difference 'Client.count' do
      client[:name] = ''
      post clients_url, params: { client: client }
      client[:name] = 'Peter'
      client[:email] = ''
      post clients_url, params: { client: client }
      client[:email] = 'peter@example.com'
      client[:role] = ''
      post clients_url, params: { client: client }
      client[:password] = client[:password_confirmation] = ''
      post clients_url, params: { client: client }
      client[:password] = 'foobar'
      client[:password_confirmation] = 'barfoo'
      post clients_url, params: { client: client }
    end
    assert_response(400)
  end

end
