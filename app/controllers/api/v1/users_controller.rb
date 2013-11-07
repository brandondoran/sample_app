module Api
  module V1
    class UsersController < ApplicationController
      def index
        @users = User.paginate(page: params[:page])
      end
      
      def show
        @user = User.find(params[:id])
      end
    end
  end
end