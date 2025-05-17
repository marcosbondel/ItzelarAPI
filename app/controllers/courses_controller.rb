class CoursesController < ApplicationApiController
    before_action :set_course, only: %i[ show update destroy ]

    # GET /courses
    def index
        @courses = @current_user.courses
        
        respond_with_success @courses.list
    end

    # GET /courses/1
    def show
        return respond_with_not_found if @course.nil?

        respond_with_success @course.show
    end

    # POST /courses
    def create
        @course = @current_user.courses.new(course_params)

        authorize @course

        unless @course.save
            return respond_with_error "Course not created", @course.errors.full_messages
        end

        respond_with_success @course.show
    end

    # PATCH/PUT /courses/1
    def update
        return respond_with_not_found if @course.nil?

        authorize @course

        if @course.update(course_params)
            respond_with_success @course.show
        else
            respond_with_error "Course not updated", @course.errors.full_messages
        end
    end

    # DELETE /courses/1
    def destroy
        return respond_with_not_found if @course.nil?

        authorize @course

        unless @course.destroy
            return respond_with_error "Course not deleted", @course.errors.full_messages
        end

        respond_with_success({ message: "Course deleted" })
    end

    private
        # Use callbacks to share common setup or constraints between actions.
        def set_course
            # @course = Course.find(params.expect(:id))
            @course = @current_user.courses.find_by(id: params[:id])
        end

        # Only allow a list of trusted parameters through.
        def course_params
            params.expect(course: [ :name, :description, :category ])
        end
end
