class MessagesController < ApplicationController

  SYSTEM_PROMPT = "You are an AI expert in business strategy and entrepreneurial support.
  You analyze the needs of companies and provide clear, personalized, and actionable advice to improve their performance and achieve their goals.
  The user is an entrepreneur who has just registered on the application and entered information about their company (industry, size, description, objectives, location).
  Based on the data provided by the user, generate a plan of practical and tailored recommendations for their business.
  The advice should focus on growth, marketing strategy, internal optimization, or any other priority linked to the defined objectives.
  Present the response in a structured format in different paragraphs and write the paragraph's title in bold. Paragraphs should be :
  1 -> short summary of the company profile
  2 -> brief analysis of the objectives including strengths, risks, and opportunities.
  3 -> three concrete and directly actionable strategic recommendations.
  4-> one suggested next step to move forward."

  def index
    @company = Company.find(params[:company_id])
  end

  def new
    @company = Company.find(params[:company_id])
    @message = Message.new
  end

  def create
    @chat = Chat.find(params[:chat_id])
    @message = Message.new(message_params)
    @message.role = 'user'
    @message.chat = @chat
    if @message.valid?
      @chat.with_instructions(instructions).ask(@message.content)
      respond_to do |format|
        format.turbo_stream # renders `app/views/messages/create.turbo_stream.erb`
        format.html { redirect_to chat_path(@chat) }
      end
    else
      respond_to do |format|
        format.turbo_stream { render turbo_stream: turbo_stream.replace("new_message", partial: "messages/form", locals: { chat: @chat, message: @message }) }
        format.html { render "chats/show", status: :unprocessable_entity }
      end
    end
  end

  private

  def message_params
    params.require(:message).permit(:content)
  end

  def company_context
    "Here's everything you need to know about my company I tried to be the most specific possible. My activity : #{@chat.company.activity},
    description : #{@chat.company.description}
    objectives : #{@chat.company.objectives}
    location : #{@chat.company.location}
    size : #{@chat.company.size}"
  end

  def instructions
    [SYSTEM_PROMPT, company_context].compact.join("\n\n")
  end
end
