Backbone::Application.routes.draw do

  get :dashboard, to: 'admin#dashboard', as: :dashboard

  devise_for :users, :controllers => { :registrations => :registrations }

  # Static Pages
  %w[about contact pricing].each do |page|
    get page, to: "home##{page}", as: page.to_sym
  end
  
  # Root Route
  root to: 'home#index'
  
end