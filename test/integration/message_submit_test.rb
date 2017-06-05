require 'test_helper'

class MessageSubmitTest < ActionDispatch::IntegrationTest

  test 'unread messages of receiver should appear when a new message is sent' do
    sender1 = clients(:john)
    sender2 = clients(:robert)
    receiver = clients(:mark)
    assert receiver.unread_messages.empty?
    assert_difference 'receiver.unread_messages.count', 2 do
      post messages_url, params: { message: { content: 'Hi bro!', sender_id: sender1.id, receiver_id: receiver.id } }
      post messages_url, params: { message: { content: 'Hi bro!', sender_id: sender2.id, receiver_id: receiver.id } }
    end
  end

end
