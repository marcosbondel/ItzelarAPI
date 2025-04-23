class Course::Exam::QuestionsController < ApplicationApiController
    before_action :set_course
    before_action :set_exam
    before_action :set_question, only: %i[ show update destroy ]
    
    # GET /questions
    def index
        @questions = @exam.questions

        respond_with_success @questions
    end
    
    # GET /questions/1
    def show
        return respond_with_not_found if @question.nil?

        respond_with_success @question
    end
    
    # POST /questions
    def create
        @question = @exam.questions.new(question_params)

        unless @question.save
            return respond_with_error "Could not create the question", @question.errors.full_messages.join(", ")
        end

        respond_with_success @question
    end
    
    # PATCH/PUT /questions/1
    def update
        return respond_with_not_found if @question.nil?

        unless @question.update(question_params)
            return respond_with_error "Could not update the question", @question.errors.full_messages.join(", ")
        end

        respond_with_success @question
    end
    
    # DELETE /questions/1
    def destroy
        return respond_with_not_found if @question.nil?

        unless @question.destroy
            return respond_with_error "Could not delete the question", @question.errors.full_messages.join(", ")
        end

        respond_with_success({ message: "Question deleted" })
    end
    
    private
        def set_course
            @course = @current_user.courses.find_by(id: params.expect(:course_id))
        end
        
        def set_exam
            return respond_with_not_found if @course.nil?
            @exam = @course.exams.find_by(id: params.expect(:exam_id))
        end
        
        # Use callbacks to share common setup or constraints between actions.
        def set_question
            return respond_with_not_found if @exam.nil?
            @question = @exam.questions.find_by(id: params.expect(:id))
        end
    
        # Only allow a list of trusted parameters through.
        def question_params
            params.expect(question: [ :question_text, :question_type ])
        end
end