# frozen_string_literal: true

class ConversationsController < ApplicationController
  before_action :set_receiver, only: :create

  def index
    conversations = @user.conversations
    render json: conversations
  end

  def create
    conversation = Conversation.new do |c|
      [@user, @receiver].each do |user|
        c.participants.new(user_id: user.id)
      end
    end
    if conversation.save
      serialized_data = ActiveModelSerializers::Adapter::Json.new(
        ConversationSerializer.new(conversation)
      ).serializable_hash

      ActionCable.server.broadcast 'conversation_channel', serialized_data
      head :ok
    end
  end

  private

  def set_receiver
    @receiver = User.find_by(id: params[:receiver_id])
    render json: { message: 'Receiver not found' } unless @receiver
  end
end
