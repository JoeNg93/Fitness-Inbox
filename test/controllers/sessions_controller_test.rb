require 'test_helper'

class SessionsControllerTest < ActionDispatch::IntegrationTest

  test 'should login with valid credentials' do
    client = clients(:mark)
    post login_path, params: { client: { email: 'marktheman@example.com', password: 'password' } }
    assert_response :success
    client_response = JSON.parse(response.body)
    assert_equal client.email, client_response['email']
  end

  test 'should response 401 with invalid credentials' do
    post login_path, params: { client: { email: 'marktheman@example.com', password: 'passworddd' } }
    assert_response(401)
    post login_path, params: { client: { email: 'markkk@gmail.com', password: 'passworddd' } }
    assert_response(401)
  end

  test 'should logout successfully when logged in' do
    post login_path, params: { client: { email: 'marktheman@example.com', password: 'password' } }
    post logout_path
    assert_response :success
  end

  test 'should response 401 if log out without logging in before' do
    post logout_path
    assert_response(401)
  end

  test 'should authenticate successfully after logging in' do
    client = clients(:mark)
    post login_path, params: { client: { email: 'marktheman@example.com', password: 'password' } }
    get authenticate_path
    assert_response :success
    client_response = JSON.parse(response.body)
    assert_equal client.email, client_response['email']
  end

  test 'should not authenticate if not logged in' do
    get authenticate_path
    assert_response(401)
  end

end
