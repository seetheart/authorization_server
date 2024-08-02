module Api
  module V1
    class AppController < ApplicationController
      before_action :set_app, only: %i[show update destroy]

      def index
        render json: Application.all.as_json(except: %i[created_at updated_at]), status: :ok
      end

      def create
        app = Application.new(name: params[:application_name])
        if app.save
          render json: app, status: :created
        else
          render_500
        end
      end

      def show
        if @app
          render json: @app, status: :ok
        else
          render_500
        end
      end

      def update
        if @app.update(update_params)
          render json: @app, status: :ok
        else
          render_500
        end
      end

      def destroy
        if @app.delete
          render json: { message: "Application deleted"}
        else
          render_500
        end
      end

      private

      def set_app
        @app = Application.find_by_id(params[:id])
      end

      def update_params
        params.permit(:name)
      end
    end
  end
end
