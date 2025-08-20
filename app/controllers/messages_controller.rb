class MessagesController < ApplicationController
  def new
    @company = Company.find(params[:company_id])
    @message = Message.new
  end
  end
