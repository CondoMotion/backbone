Backbone::Application.routes.draw do

  get :dashboard, to: 'admin#dashboard', as: :dashboard

  devise_for :users, :controllers => { :registrations => :registrations }
  devise_scope :user do
    get 'sign_up/:plan_id', to: 'registrations#new'
    get 'sign_in', to: 'devise/sessions#new', as: :new_user_session
  end

  # Static Pages
  %w[about contact pricing].each do |page|
    get page, to: "home##{page}", as: page.to_sym
  end
  
  # Root Route
  root to: 'home#index'
  
end