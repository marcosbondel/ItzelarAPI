Rails.application.routes.draw do
    # Defines the root path route ("/")
    # root "posts#index"
    
    # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
    
    # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
    # Can be used by load balancers and uptime monitors to verify that the app is live.
    get "up" => "rails/health#show", as: :rails_health_check
    

    namespace :auth do
        post '/sign_in', to: 'sessions#sign_in'
        post '/sign_up', to: 'sessions#sign_up'
        post '/logout', to: 'sessions#logout'
    end
    
    resources :roles
    resources :courses do
        resources :lessons

        resources :examns do
            resources :questions do
                resources :options
                resources :answers
            end
        end
    end
end
