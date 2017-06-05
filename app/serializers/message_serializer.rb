class MessageSerializer < ActiveModel::Serializer
  attributes :id, :content
  belongs_to :sender
  belongs_to :receiver
end
