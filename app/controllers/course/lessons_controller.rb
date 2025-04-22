class Course::LessonsController < ApplicationApiController
    before_action :set_course
    before_action :set_lesson, only: %i[ show update destroy ]

    # GET /lessons
    def index
        @lessons = @course.lessons

        respond_with_success @lessons
    end

    # GET /lessons/1
    def show
        return respond_with_not_found if @course.nil?
        return respond_with_not_found if @lesson.nil?

        respond_with_success @lesson
    end

    # POST /lessons
    def create
        return respond_with_not_found if @course.nil?
        
        @lesson = @course.lessons.new(lesson_params)

        unless @lesson.save
            return respond_with_error "Could not create the lesson", @lesson.errors.full_messages.join(", ")
        end

        respond_with_success @lesson
    end

    # PATCH/PUT /lessons/1
    def update
        return respond_with_not_found if @course.nil?
        return respond_with_not_found if @lesson.nil?

        unless @lesson.update(lesson_params)
            return respond_with_error "Could not update the lesson", @lesson.errors.full_messages.join(", ")
        end

        respond_with_success @lesson
    end

    # DELETE /lessons/1
    def destroy
        return respond_with_not_found if @course.nil?
        return respond_with_not_found if @lesson.nil?

        unless @lesson.destroy
            return respond_with_error "Could not delete the lesson", @lesson.errors.full_messages.join(", ")
        end

        respond_with_success({ message: "Lesson deleted" })

    end

    private
        def set_course
            @course = @current_user.courses.find(params.expect(:course_id))
        end

        # Use callbacks to share common setup or constraints between actions.
        def set_lesson
            @lesson = Lesson.find(params.expect(:id))
        end

        # Only allow a list of trusted parameters through.
        def lesson_params
            params.expect(lesson: [ :title, :content, :order ])
        end
end