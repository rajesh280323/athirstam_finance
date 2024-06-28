Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
 
  devise_scope :employee do  
   get '/employees/sign_out' => 'devise/sessions#destroy'     
   get '/change_password', to: 'employees/registrations#change_password'
   post '/updated_password', to: 'employees/registrations#updated_password'
  end

  devise_for :employees, controllers: {
  # registrations: 'employees/registrations',
  sessions: 'employees/sessions',
  passwords: 'employees/passwords',
  # Add other controllers as needed
}
  resources :home
  resources :areas
  resources :leaders
  resources :applicant_users
  resources :loans
# resources :areas, only: [:index]

  # Defines the root path route ("/")
  root "home#index"
end
