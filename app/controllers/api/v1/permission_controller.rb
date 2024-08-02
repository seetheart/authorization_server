module Api
  module V1
    class PermissionController < ApplicationController
      before_action :set_permission, only: %i[show update destroy]

      def index
        render json: Permission.where(role_id: params[:role_id]).as_json(except: %i[created_at updated_at]), status: :ok
      end

      def create
        permission = Permission.new(name: params[:role_name], role_id: params[:role_id])
        if permission.save
          render json: permission, status: :created
        else
          render_500
        end
      end

      def show
        if @permission
          render json: @permission, status: :ok
        else
          render_500
        end
      end

      def update
        if @permission.update(update_params)
          render json: @permission, status: :ok
        else
          render_500
        end
      end

      def destroy
        if @permission.delete
          render json: { message: "Role deleted"}
        else
          render_500
        end
      end

      private

      def set_permission
        @permission = Permission.find_by_id(params[:id])
      end

      def update_params
        params.permit(:name)
      end
    end
  end
end
