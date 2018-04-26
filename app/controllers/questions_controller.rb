class QuestionsController < ApplicationController
    before_action :authenticate_user
    before_action :set_user
    before_action :set_test
    before_action :set_test_question, only: [:show, :update, :destroy]

    # GET /users/:user_id/tests/:test_id/questions
    def index
        if current_user == @user
          json_response(@test.questions)
        else
          json_response(@test.questions.where(status: :published))
        end
    end

    # GET /users/:user_id/tests/:test_id/questions/:id
    def show
        if current_user == @user
            json_response(@question)
        else
            if @test.published?
              json_response(@question)
            else
              json_response({'status' => 'unauthorized'}, :unauthorized)
            end
        end
    end

    # POST /users/:user_id/tests/:test_id/questions
    def create
      if current_user == @user
        @test.questions.create!(question_params)
        @question = @test.questions.last
        json_response(@question, :created)
      else
        json_response({'status' => 'unauthorized'}, :unauthorized)
      end
    end

    # PUT /users/:user_id/tests/:test_id/questions/:id
    def update
      if current_user == @user
        @question.update(question_params)
        head :no_content
      else
          json_response({'status' => 'unauthorized'}, :unauthorized)
      end
    end

    # DELETE /users/:user_id/tests/:test_id/questions/:id
    def destroy
      if current_user == @user
          @question.destroy
          head :no_content
      else
          json_response({'status' => 'unauthorized'}, :unauthorized)
      end
    end

    private
        def question_params
            # whitelist params
            params.require(:question).permit(:description, :thumbnail, :user_id, :test_id)
        end
        # Use callbacks to share common setup or constraints between actions.
        def set_user
            @user = User.find(params[:user_id])
        end

        def set_test
            @test = @user.tests.find_by!(id: params[:test_id]) if @user
        end

        def set_test_question
            @question = @test.questions.find_by!(id: params[:id]) if @test
        end
end
