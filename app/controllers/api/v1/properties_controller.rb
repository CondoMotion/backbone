module Api
  module V1
    class PropertiesController < ApplicationController
      respond_to :json
      
      def index
        respond_with Property.all
      end
      
      def show
        respond_with Property.find(params[:id])
      end
      
      def create
        respond_with Property.create(params[:property])
      end
      
      def update
        respond_with Property.update(params[:id], params[:properties])
      end
      
      def destroy
        respond_with Property.destroy(params[:id])
      end

    end
  end
end
