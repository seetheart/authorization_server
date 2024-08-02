module Api
  module V1
    class AuthorizationController < ApplicationController
      def authorize
        serv = AuthorizeService.new(auth_params)
        render_service(serv)
      end

      private
      def auth_params
        params.permit(:role_name, :action_name, :application_name)
      end
    end
  end
end
