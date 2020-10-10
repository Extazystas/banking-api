module Api
  class BaseController < ApplicationController
    before_action :authenticate_request

    attr_reader :current_user

    private

    def authenticate_request
      @current_user = api_authorizer(request.headers).result
      render json: { error: 'Not Authorized' }, status: 401 unless @current_user
    end

    def api_authorizer(headers)
      ::AuthorizeApiRequest.call(headers)
    end
  end
end
