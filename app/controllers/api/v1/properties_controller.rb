module Api
  module V1
    class PropertiesController < BaseController
      respond_to :json
      
      def index
        render json: Property.all
      end
      
      def show
        @property = Property.find(params[:id])
        respond_to do |format|
          format.json { render json: @property }
        end
      end
      
      def create
        @property = Property.new(params[:property])

        if @property.save
          respond_to do |format|
            format.json { render json: @property }
          end
        else
          respond_with Property.create(params[:property])
        end
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
