module Api
  module V1
    class RoleController < ApplicationController
      before_action :set_role, only: %i[show update destroy]

      def index
        render json: Role.where(application_id: params[:app_id]).as_json(except: %i[created_at updated_at]), status: :ok
      end

      def create
        role = Role.new(name: params[:role_name], application_id: params[:app_id])
        if role.save
          render json: role, status: :created
        else
          render_500
        end
      end

      def show
        if @role
          render json: @role, status: :ok
        else
          render_500
        end
      end

      def update
        if @role.update(update_params)
          render json: @role, status: :ok
        else
          render_500
        end
      end

      def destroy
        if @role.delete
          render json: { message: "Role deleted"}
        else
          render_500
        end
      end

      private

      def set_role
        @role = Role.find_by_id(params[:id])
      end

      def update_params
        params.permit(:name)
      end
    end
  end
end
