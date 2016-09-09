class ApiController < ApplicationController
  skip_before_action :verify_authenticity_token

  private

  def authenticated?
    authenticate_or_request_with_http_basic {|username, password| User.where(name: username, password_digest: password).present? }
  end

end
