class CompaniesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_company, only: [:show]

def index
  @companies = current_user.companies
end

def show
  set_company
end

def new
  @company = Company.new
end

def create
  @company = Company.new(company_params)
  @company.user = current_user
    if @company.save
      redirect_to companies_path, notice: "Your company's chat was successfully created."
    else
      render :new
    end
end

  private

  def set_company
    @company = current_user.companies.find(params[:id])
  end

  def company_params
    params.require(:company).permit(:name, :activity, :description, :objectives, :location, :size)
  end

end
