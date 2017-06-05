require 'test_helper'

class MessagesControllerTest < ActionDispatch::IntegrationTest

  test 'should get a list of message with GET /messages' do
    get messages_url
    assert_response :success
    assert_equal response.content_type, 'application/json'
    messages = JSON.parse(response.body)
    assert_equal Message.count, messages.length
  end

  test 'should get a single message with GET /messages/:id when id is valid' do
    message = messages(:message_john_robert)
    get message_url(message)
    assert_response :success
    assert_equal response.content_type, 'application/json'
    messageResponse = JSON.parse(response.body)
    assert_equal message.id, messageResponse['id']
  end

  test 'should get status code 404 with invalid id GET/messages/:id' do
    get message_url(id: 'Hahah')
    assert_response :missing
    assert_equal response.content_type, 'application/json'
    message = JSON.parse(response.body)
    assert message.empty?
  end

  test 'should post new message successfully with valid params' do
    sender = clients(:john)
    receiver = clients(:robert)
    assert_difference 'Message.count', 1 do
      post messages_url, params: { message: { content: 'Test Message', sender_id: sender.id, receiver_id: receiver.id } }
    end
    assert_response :success
    assert_equal response.content_type, 'application/json'
  end

  test 'should response with 400 if params are invalid' do
    sender = clients(:john)
    receiver = clients(:robert)
    assert_no_difference 'Message.count' do
      post messages_url, params: { message: { content: '    ', sender_id: sender.id, receiver_id: receiver.id } }
      post messages_url, params: { message: { content: '', sender_id: sender.id, receiver_id: receiver.id } }
      post messages_url, params: { message: { content: 'Hihihaha', receiver_id: receiver.id } }
      post messages_url, params: { message: { content: '', sender_id: sender.id } }
      post messages_url, params: { message: { content: '' } }
    end
    assert_response(400)
  end

  test 'should get a list of messages correspond to a user' do
    user = clients(:robert)
    get get_message_url(user)
    assert_response :success
    assert_equal response.content_type, 'application/json'
    messages = JSON.parse(response.body)
    assert_equal Message.where('sender_id = :id OR receiver_id = :id', id: user.id).count, messages.length
  end

end
