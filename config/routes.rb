Rails.application.routes.draw do
    get "up" => "rails/health#show", as: :rails_health_check

    namespace :auth do
        post :sign_in, to: 'sessions#sign_in'
        post :sign_up, to: 'sessions#sign_up'
        post :logout, to: 'sessions#logout'
    end
    
    resources :roles
    resources :enrollments
    resources :courses do
        scope module: :course do
            resources :lessons
            
            resources :examns do
                resources :questions do
                    resources :options
                    resources :answers
                end
            end
        end
    end
end
