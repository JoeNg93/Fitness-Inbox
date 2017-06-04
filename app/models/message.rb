class Message < ApplicationRecord

  # SCOPE
  scope :unread, -> { where(read: false) }

  # RELATIONSHIPS
  belongs_to :sender, class_name: 'Client'
  belongs_to :receiver, class_name: 'Client'

  # VALIDATES
  validates :content, presence: true

end
