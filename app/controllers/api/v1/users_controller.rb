# TODO: update the CRUD actions to use the UserBlueprint serializer

module Api
  module V1
    class UsersController < ApiController
      skip_before_action :authenticate_user, only: %i[create]
      before_action :find_user, only: %i[show update destroy]

      def index
        @users = User.all
        render json: @users, status: :ok
      end

      def create
        @user = User.new(user_params)

        if @user.save
          render json: Auth::UserBlueprint.render(@user), status: :created
        else
          render json: @user.errors, status: :unprocessable_entity
        end
      end

      def show
        render json: @user, status: :ok
      end

      def update
        if @user.update(user_params)
          render json: @user, status: :ok
        else
          render json: @user.errors, status: :unprocessable_entity
        end
      end

      def destroy
        @user.destroy
        head :ok # 200 status with no response body
      end

      def test
        render json: { message: 'Hello World' }, status: :ok
      end

      private

      def user_params
        params.require(:user).permit(:name, :email, :password, :password_confirmation)
      end

      def find_user
        @user = User.find(params[:id])
      end
    end
  end
end
