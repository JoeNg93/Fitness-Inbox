class MessageSerializer < ActiveModel::Serializer
  attributes :id, :content, :created_at, :sender_id, :receiver_id
  belongs_to :sender
  belongs_to :receiver
end
