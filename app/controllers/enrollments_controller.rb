class EnrollmentsController < ApplicationApiController
    before_action :set_enrollment, only: %i[ show update destroy ]

    # GET /enrollments
    def index
        @enrollments = @current_user.enrollments

        respond_with_success @enrollments.list
    end

    # GET /enrollments/1
    def show
        return respond_with_not_found if @enrollment.nil?

        respond_with_success @enrollment.show
    end

    # POST /enrollments
    def create
        @enrollment = @current_user.enrollments.new(enrollment_params)
        @enrollment.status = :enrolled
        
        if @enrollment.save
            respond_with_success @enrollment.show
        else
            respond_with_error "Could not enroll", @enrollment.errors.full_messages
        end
    end

    # PATCH/PUT /enrollments/1
    def update
        return respond_with_not_found if @enrollment.nil?

        if @enrollment.update(enrollment_params)
            respond_with_success @enrollment.show
        else
            respond_with_error "Enrollment not updated", @enrollment.errors.full_messages
        end
    end

    # DELETE /enrollments/1
    def destroy
        return respond_with_not_found if @enrollment.nil?

        unless @enrollment.destroy
            return respond_with_error "Enrollment not deleted", @enrollment.errors.full_messages
        end

        respond_with_success({ message: "Enrollment deleted" })
    end

    private
        # Use callbacks to share common setup or constraints between actions.
        def set_enrollment
            @enrollment = @current_user.enrollments.find_by(id: params[:id])
        end

        # Only allow a list of trusted parameters through.
        def enrollment_params
            params.expect(enrollment: [ :course_id ])
        end
end
