require 'test_helper'

class MessageTest < ActiveSupport::TestCase
  def setup
    @first_user = clients(:john)
    @second_user = clients(:robert)
    @message1 = Message.new(content: 'Hi Robert! How are you?', sender_id: @first_user.id,
                            receiver_id: @second_user.id)
  end

  test 'should be valid' do
    assert @message1.valid?
  end

  test 'content should be present' do
    @message1.content = '   '
    assert_not @message1.valid?
  end

  test 'sender_id and receiver_id should be present' do
    @message1.sender_id = @message1.receiver_id = nil
    assert_not @message1.valid?
  end

  test 'read should be false by default' do
    @message1.save
    assert_not @message1.read
  end

  test 'message should appear in unread of receiver after saved' do
    assert @second_user.unread_messages.empty?
    @message1.save
    assert_not @second_user.unread_messages.empty?
  end

  test 'message should be deleted from unread messages of receiver after being marked as read' do
    @message1.save
    assert_not @second_user.unread_messages.empty?
    @message1.update_attribute(:read, true)
    assert @second_user.unread_messages.empty?
  end

end
