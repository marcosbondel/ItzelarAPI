class Course::ExamsController < ApplicationApiController
    before_action :set_course
    before_action :set_exam, only: %i[ show update destroy ]

    # GET /exams
    def index
        @exams = @course.exams

        respond_with_success @exams
    end

    # GET /exams/1
    def show
        return respond_with_not_found if @exam.nil?

        respond_with_success @exam 
    end

    # POST /exams
    def create
        @exam = Exam.new(exam_params)
        @exam = @course.exams.new(exam_params)

        unless @exam.save
            return respond_with_error "Could not create the exam", @exam.errors.full_messages.join(", ")
        end

        respond_with_success @exam
    end

    # PATCH/PUT /exams/1
    def update
        return respond_with_error if @exam.nil?

        unless @exam.update(exam_params)
            return respond_with_error "Could not update the exam", @exam.errors.full_messages.join(", ")
        end

        respond_with_success @exam
    end

    # DELETE /exams/1
    def destroy
        return respond_with_not_found if @exam.nil?

        unless @exam.destroy
            return respond_with_error "Could not delete the exam", @exam.errors.full_messages.join(", ")
        end

        respond_with_success({ message: "Exam deleted" })
    end

        
    private
        def set_course
            @course = @current_user.courses.find(params.expect(:course_id))
        end

        # Use callbacks to share common setup or constraints between actions.
        def set_exam
            return respond_with_not_found if @course.nil?
            @exam = @course.exams.find_by(id: params.expect(:id))
        end

        # Only allow a list of trusted parameters through.
        def exam_params
            params.expect(exam: [ :title, :description ])
        end
end