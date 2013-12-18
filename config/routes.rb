Backbone::Application.routes.draw do

  constraints lambda { |r| !r.subdomain.present? || r.subdomain == 'www' || r.subdomain == "cmo-backbone" } do
    devise_for :users, controllers: { registrations: :registrations }
    devise_scope :user do
      get 'sign_up/:plan_id', to: 'registrations#new'
    end
    %w[about contact pricing].each do |page|
      get page, to: "home##{page}", as: page.to_sym
    end
    root to: 'home#index'
  end

  constraints lambda { |r| r.subdomain.present? && r.subdomain != 'www' } do
    namespace :admin do
      resources :subscriptions, only: :update
      devise_for :users, skip: [:sessions, :registrations]
      root to: 'dashboard#index'
    end
    root to: 'admin/companies#show', as: :company_root
    devise_scope :admin_user do
      get 'admin/sign_in', to: 'admin/sessions#new', as: :new_admin_user_session
      post 'admin/sign_in', to: 'admin/sessions#create', as: :admin_user_session
      delete 'admin/sign_out', to: 'admin/sessions#destroy', as: :destroy_admin_user_session
      get 'admin/settings', to: 'admin/registrations#edit', as: :edit_admin_user_registration
      put 'admin/settings', to: 'admin/registrations#update', as: :admin_user_registration
    end
  end 

  constraints lambda { |r| r.subdomain.present? && r.subdomain != 'www' } do
    namespace :resident_portal do

    end
  end

  namespace :api do
    namespace :v1 do
      resources :properties
    end
  end

  get :prototype, to: 'prototypes#index'
  
end