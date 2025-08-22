class MessagesController < ApplicationController

  SYSTEM_PROMPT = "You are an AI expert in business strategy and entrepreneurial support and very pedagogical
  You analyze the needs of companies and provide clear, personalized, and actionable advice to improve their performance and achieve their goals.
  The user is an entrepreneur who has just registered on the application and entered information about their company (industry, size, description, objectives, location).
  Based on the data provided by the user, generate a plan of practical and tailored recommendations for their business

  Explain it
  The advice should focus on growth, marketing strategy, internal optimization, or any other priority linked to the defined objectives.

  Analyze deeply and precisely the content of the files given if there are ones.

  Be consice !!

  Provide step-by-step instructions in bullet points, using markdown"

  def index
    @company = Company.find(params[:company_id])
  end

  def create
    @chat = Chat.find(params[:chat_id])
    @message = Message.new(message_params)
    @message.role = 'user'
    @message.chat = @chat
    if @message.save
      if @message.file.attached?
        process_file(@message.file)
      else
        send_question
      end
      Message.create(role: "assistant", content: @response.content, chat: @chat)
        respond_to do |format|
        format.turbo_stream
        format.html { redirect_to chat_path(@chat) }
      end
    else
      respond_to do |format|
        format.turbo_stream { render turbo_stream: turbo_stream.replace("new_message", partial: "messages/form", locals: { chat: @chat, message: @message }) }
        format.html { render "chats/show", status: :unprocessable_entity }
      end
    end
  end

  def process_file(file)
    if file.content_type == "application/pdf"
      send_question(model: "gemini-2.0-flash", with: { pdf: @message.file.url })

    elsif file.image?
      send_question(model: "gpt-4o", with: { image: @message.file.url })
    end
  end

  def send_question(model: "gpt-4.1-nano", with: {})
    @ruby_llm_chat = RubyLLM.chat(model: model)
    build_conversation_history
    @response = @ruby_llm_chat.with_instructions(instructions).ask(@message.content, with: with)
  end

  def build_conversation_history
    @chat.messages.each do |message|
      @ruby_llm_chat.add_message(content: message.content, role: message.role)
    end
  end

  private

  def message_params
    params.require(:message).permit(:content, :file)
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
