class PagesController < ApplicationController
  def home
    if current_user
      @companies = current_user.companies
    end
  end


end
