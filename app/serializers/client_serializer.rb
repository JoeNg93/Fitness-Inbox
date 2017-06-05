class ClientSerializer < ActiveModel::Serializer
  attributes :id, :name, :email, :role

  has_many :unread_messages, serializer: MessageSerializer
end
