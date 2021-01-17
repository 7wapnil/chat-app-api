class ConversationSerializer < ActiveModel::Serializer
  attributes :title
  has_many :messages
end
