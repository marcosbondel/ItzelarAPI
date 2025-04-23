class Course::Exam::Question::OptionsController < ApplicationApiController
    before_action :set_course
    before_action :set_exam
    before_action :set_question
    before_action :set_option, only: %i[ show update destroy ]
    
    # GET /options
    def index
        @options = @question.options

        respond_with_success @options
    end
    
    # GET /options/1
    def show
        return respond_with_not_found if @option.nil?

        respond_with_success @option
    end
    
    # POST /options
    def create
        @option = @question.options.new(option_params)

        unless @option.save
            return respond_with_error "Could not create the question", @option.errors.full_messages.join(", ")
        end

        respond_with_success @option
    end
    
    # PATCH/PUT /options/1
    def update
        return respond_with_not_found if @option.nil?

        unless @option.update(option_params)
            return respond_with_error "Could not update the question", @option.errors.full_messages.join(", ")
        end

        respond_with_success @option
    end
    
    # DELETE /options/1
    def destroy
        return respond_with_not_found if @option.nil?

        unless @option.destroy
            return respond_with_error "Could not delete the question", @option.errors.full_messages.join(", ")
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
            @question = @exam.questions.find_by(id: params.expect(:question_id))
        end

        def set_option
            return respond_with_not_found if @question.nil?
            @option = @question.options.find_by(id: params.expect(:id))
        end
    
        # Only allow a list of trusted parameters through.
        def option_params
            params.expect(option: [ :option_text, :is_correct ])
        end
end