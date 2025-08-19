class ApplicationController < ActionController::Base
  def after_sign_in_path_for(resource)
    test_path
  end
end
