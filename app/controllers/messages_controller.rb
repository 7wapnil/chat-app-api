class MessagesController < ApplicationController
  before_action :set_conversation, only: :create

  def create
    message = @conversation.messages.new(message_params)
    if message.save
      serialied_data = ActiveModelSerializers::Adapter::Json.new(
        MessageSerializer.new(message)
      ).serializable_hash
      MessagesChannel.broadcast_to @conversation, serialized_data
      head :ok
    end
  end

  private

  def message_params
    params.require(:message).permit(:content).merge({ user_id: @user.id })
  end

  def set_conversation
    @conversation = Conversation.find_by(id: params[:conversation_id])
    render json: { message: 'Conversation not found' } unless @conversation
  end
end
