class TestsController < ApplicationController
    before_action :authenticate_user
    before_action :set_user
    before_action :set_user_test, only: [:show, :update, :destroy]

    # GET /users/:user_id/tests
    def index
        if current_user == @user
          json_response(@user.tests)
        else
          json_response(@user.tests.where(status: :published))
        end
    end

    # GET /users/:user_id/users/:id
    def show
        if @test.published?
          json_response(@test)
        else
          json_response({'status' => 'unauthorized'}, :unauthorized)
        end
    end

    # POST /users/:user_id/tests
    def create
      if current_user == @user
        @user.tests.create!(test_params)
        @test = @user.tests.last
        json_response(@test, :created)
      else
        json_response({'status' => 'unauthorized'}, :unauthorized)
      end
    end

    # PUT /users/:user_id/tests/:test_id
    def update
      if current_user == @user
        @test.update(test_params)
        head :no_content
      else
          json_response({'status' => 'unauthorized'}, :unauthorized)
      end
    end

    # DELETE /users/:user_id/tests/:test_id
    def destroy
      if current_user == @user
          @test.destroy
          head :no_content
      else
          json_response({'status' => 'unauthorized'}, :unauthorized)
      end
    end

    private
        def test_params
            # whitelist params
            params.permit(:description, :status, :user_id)
        end
        # Use callbacks to share common setup or constraints between actions.
        def set_user
            @user = User.find(params[:user_id])
        end

        def set_user_test
            @test = @user.tests.find_by!(id: params[:id]) if @user
        end
end
