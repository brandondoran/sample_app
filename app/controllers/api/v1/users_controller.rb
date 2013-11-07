module Api
  module V1
    class UsersController < ApplicationController
      before_filter :restrict_access

      def index
        @users = User.paginate(page: params[:page])
      end
      
      def show
        @user = User.find(params[:id])
      end

      private

        def restrict_access
          authenticate_or_request_with_http_token do |token, options|
            ApiKey.exists?(access_token: token)
          end
        end
    end
  end
end