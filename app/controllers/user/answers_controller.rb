class User::AnswersController < ApplicationApiController
    before_action :set_user
    before_action :set_answer, only: %i[ show update destroy ]

    # GET /answers
    def index
        @answers = @user.answers
        
        respond_with_success @answers
    end

    # GET /answers/1
    def show
        return respond_with_not_found if @answer.nil?

        respond_with_success @answer
    end

    # POST /answers
    def create
        @answer = @user.answers.new(answer_params)
        @answer.question = Question.find_by(id: answer_params[:question_id])

        unless @answer.question.answer.nil?
            return respond_with_error "Answer already exists", "Answer for question with id #{params[:question_id]} already exists"
        end
        
        if @answer.question.nil?
            return respond_with_error "Question not found", "Question with id #{params[:question_id]} not found"
        end
        
        @answer.is_correct = false

        correct_answer = @answer.question.options.find_by(is_correct: true)
        
        if not correct_answer.nil?
            @answer.is_correct = true if @answer.response == correct_answer.option_text
        end
        
        unless @answer.save
            return respond_with_error "Answer not created", @answer.errors.full_messages.join(", ")
        end
        
        return respond_with_success @answer
    end

    # PATCH/PUT /answers/1
    def update
        return respond_with_not_found if @answer.nil?

        if @answer.update(answer_params)
            respond_with_success @answer.show
        else
            respond_with_error "Answer not updated", @answer.errors.full_messages.join(", ")
        end
    end

    # DELETE /answers/1
    def destroy
        return respond_with_not_found if @answer.nil?

        unless @answer.destroy
            return respond_with_error "Answer not deleted", @answer.errors.full_messages.join(", ")
        end

        respond_with_success({ message: "Answer deleted" })
    end

    private
        # Use callbacks to share common setup or constraints between actions.
        def set_user
            @user = User.find_by(id: params[:user_id])
        end

        def set_answer
            return respond_with_not_found if @user.nil?
            @answer = @user.answers.find_by(id: params[:id])
        end

        # Only allow a list of trusted parameters through.
        def answer_params
            params.expect(answer: [ :response, :is_correct, :question_id ])
        end

end