class ApiController < ApplicationController
  skip_before_action :verify_authenticity_token

  class << self
    Swagger::Docs::Generator::set_real_methods

    def inherited(subclass)
      super
      subclass.class_eval do
        setup_basic_api_documentation
      end
    end

    private
    def setup_basic_api_documentation
      [:index, :show, :create, :update, :delete].each do |api_action|
        swagger_api api_action do
          param :header, 'Authentication-Token', :string, :required, 'Authentication token'
        end
      end
    end
  end

  private

  def authenticated?
    authenticate_or_request_with_http_basic {|username, password| User.where(name: username, password_digest: password).present? }
  end

end
