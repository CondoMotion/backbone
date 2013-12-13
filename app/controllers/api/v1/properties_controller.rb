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
        
        respond_to do |format|
          if @property.save
            format.json { render json: @property }
          else
            format.json { render json: { errors: @property.errors }, :status => 422 }
          end
        end
      end

      def update
        @property = Property.find(params[:id])

        respond_to do |format|
          if @property.update_attributes(params[:property])
            format.json { render json: @property }
          else
            format.json { render json: { errors: @property.errors }, :status => 422 }
          end
        end
      end
      
      def destroy
        respond_with Property.destroy(params[:id])
      end
    end
  end
end
