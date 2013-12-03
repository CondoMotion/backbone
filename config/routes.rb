Backbone::Application.routes.draw do

  constraints lambda { |r| r.subdomain.present? && r.subdomain != 'www' } do
    namespace :admin do
      devise_for :users, skip: [:sessions]
      root to: 'dashboard#index'
    end
    root to: 'admin/companies#show', as: :company_root
    devise_scope :admin_user do
      get 'admin/sign_in' => 'admin/sessions#new', :as => :new_admin_user_session
      post 'admin/sign_in' => 'admin/sessions#create', :as => :admin_user_session
      delete 'admin/sign_out' => 'admin/sessions#destroy', :as => :destroy_admin_user_session
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

  constraints lambda { |r| !r.subdomain.present? || r.subdomain == 'www' } do
    devise_for :users, controllers: { registrations: :registrations }
    devise_scope :user do
      get 'sign_up/:plan_id', to: 'registrations#new'
    end
    %w[about contact pricing].each do |page|
      get page, to: "home##{page}", as: page.to_sym
    end
    root to: 'home#index'
  end
  
end