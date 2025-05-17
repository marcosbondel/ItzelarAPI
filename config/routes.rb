Rails.application.routes.draw do
    get "up" => "rails/health#show", as: :rails_health_check

    namespace :auth do
        post :sign_in, to: 'sessions#sign_in'
        post :sign_up, to: 'sessions#sign_up'
        post :logout, to: 'sessions#logout'
    end

    # /user/profile
    namespace :user do
        resource :profile, only: %i(show)
    end
    
    resources :roles
    resources :enrollments

    resources :users do
        scope module: :user do
            resources :answers
        end
    end

    resources :courses do
        scope module: :course do
            resources :lessons
            resources :exams do
                scope module: :exam do
                    resources :questions do
                        scope module: :question do
                            resources :options
                            resources :answers
                        end
                    end
                end
            end
        end
    end
end
