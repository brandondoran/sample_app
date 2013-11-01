module Api
  module V1
    class MicropostsController < ApplicationController
    	respond_to :json
    	
      def index
        respond_with Micropost.all
    	end

      def show
        micropost = Micropost.find(params[:id])
        if !micropost.nil?
          respond_with micropost
        else
          respond_with status: :not_found
        end
      end
    end
  end
end

