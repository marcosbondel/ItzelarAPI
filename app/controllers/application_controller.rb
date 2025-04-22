class ApplicationController < ActionController::API
    include Application::Responder

    rescue_from ActionController::ParameterMissing, with: :handle_missing_params

    private 

        def handle_missing_params(exception)
            return respond_with_error "Parameter missing: #{exception.param}"
        end
end
