module Application
    module Responder
        extend ActiveSupport::Concern

        included do
            def respond_with_success data = {}
                respond_with_http 200, data
            end

            def respond_with_error message = 'Something went wrong', details = []
                respond_with_http 400, { message: message, details: details } 
            end

            def respond_with_not_found message = 'Resource not found'
                respond_with_http 404, { message: message } 
            end

            def respond_with_unauthorized message = 'Unauthorized' 
                respond_with_http 401, { message: message }
            end
    
            def respond_with_http status, payload
                return render(status: status, content_type: 'application/json', json: payload.to_json) unless payload.nil?
                return render(status: status, content_type: 'application/json', json: "")
            end
        end
    end
end