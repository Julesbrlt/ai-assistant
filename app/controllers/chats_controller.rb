class ChatsController < ApplicationController

  def index
    @company = Company.find(params[:company_id])
    @chats = current_user.chats.where(company: @company)
    @chat = Chat.new
  end

  def show
    @chat = Chat.find(params[:id])
    @message = Message.new
  end

  def create
    @company = Company.find(params[:company_id])
    @chat = Chat.new(title: 'untitled', model_id: 'gpt-4.1-nano')
    @chat.company = @company
    @chat.user = current_user
    if @chat.save
      redirect_to chat_path(@chat)
    else
      render :index
    end
  end
end
