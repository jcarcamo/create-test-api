class AnswersController < ApplicationController
    before_action :authenticate_user
    before_action :set_user
    before_action :set_test
    before_action :set_question
    before_action :set_question_answer, only: [:show, :update, :destroy]

    # GET /users/:user_id/tests/:test_id/questions/:question_id/answers
    def index
        if current_user == @user
          json_response(@question.answers)
        else
            if @test.published?
                json_response(@question.answers)
            end
        end
    end

    # GET /users/:user_id/tests/:test_id/questions/:question_id/answers/:id
    def show
        if current_user == @user
            json_response(@answer)
        else
            if @test.published?
              json_response(@answer)
            else
              json_response({'status' => 'unauthorized'}, :unauthorized)
            end
        end
    end

    # POST /users/:user_id/tests/:test_id/questions
    def create
      if current_user == @user
        @question.answers.create!(answer_params)
        @answer = @question.answers.last
        json_response(@answer, :created)
      else
        json_response({'status' => 'unauthorized'}, :unauthorized)
      end
    end

    # PUT /users/:user_id/tests/:test_id/questions/:id
    def update
      if current_user == @user
        @answer.update(answer_params)
        head :no_content
      else
          json_response({'status' => 'unauthorized'}, :unauthorized)
      end
    end

    # DELETE /users/:user_id/tests/:test_id/questions/:id
    def destroy
      if current_user == @user
          @answer.destroy
          head :no_content
      else
          json_response({'status' => 'unauthorized'}, :unauthorized)
      end
    end

    private
        def answer_params
            # whitelist params
            params.require(:answer).permit(:description, :status, :user_id, :test_id, :question_id)
        end
        # Use callbacks to share common setup or constraints between actions.
        def set_user
            @user = User.find(params[:user_id])
        end

        def set_test
            @test = @user.tests.find_by!(id: params[:test_id]) if @user
        end

        def set_question
            @question = @test.questions.find_by!(id: params[:question_id]) if @test
        end

        def set_question_answer
            @answer = @question.answers.find_by!(id: params[:id]) if @question
        end
end
