Rails.application.routes.draw do
  scope :api do
    resources :posts
    post :authenticate, to: 'auth#create', format: :json
  end
end
