class ApplicationController < ActionController::Base
  def after_sign_in_path_for(resource)
    companies_path
  end
end
