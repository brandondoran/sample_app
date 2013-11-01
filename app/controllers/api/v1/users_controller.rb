module Api
  module V1
    class UsersController < ApplicationController
      respond_to :json
      
      def index
        respond_with User.all
      end
      
      def show
        user = User.find(params[:id])
        if !user.nil?
          respond_with User.find(params[:id])
        else
          respond_with status: :not_found
        end
      end
    end
  end
end