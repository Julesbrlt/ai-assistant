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
    @company = Company.find(params[:company_id])
    @message = Message.new(role: 'user', content: params[:message][:content], company: @company)
    if @message.save
      @chat = RubyLLM.chat
      response = @chat.with_instructions(instructions).ask(@message.content)
      Message.create(role: 'assistant', content: response.content, company: @company)
    else
      render :new
    end
    redirect_to company_messages_path
  end

  private

  def company_context
    "Here's everything you need to know about my company I tried to be the most specific possible. My activity : #{@company.activity},
    description : #{@company.description}
    objectives : #{@company.objectives}
    location : #{@company.location}
    size : #{@company.size}"
  end

  def instructions
    [SYSTEM_PROMPT, company_context].compact.join("\n\n")
  end
end
