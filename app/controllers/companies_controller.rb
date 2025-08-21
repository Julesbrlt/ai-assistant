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

  def edit
    @company = Company.find(params[:id])
  end


  def destroy
    @company = Company.find(params[:id])
    @company.destroy
    redirect_to companies_path, status: :see_other
  end

  def update
    @company = Company.find(params[:id])
    @company.size = params["company"]["size"]
    if @company.update!(company_params)
      redirect_to company_path(@company), notice: "Entreprise mise à jour avec succès ✅"
    else
      render :edit, status: :unprocessable_entity
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
