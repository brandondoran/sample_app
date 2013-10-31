module Api
  module V1
    class MicropostsController < ApplicationController
    	respond_to :json
    	
      def index
        respond_with Micropost.all
    	end

      def show
        respond_with Micropost.find(params[:id])
      end
    end
  end
end

