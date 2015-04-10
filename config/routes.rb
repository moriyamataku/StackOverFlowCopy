Rails.application.routes.draw do
  resources :questions, only: [:index, :show, :new, :create, :edit, :update] do
    resources :answers, only: [:create, :edit, :update] do
      resources :comments, only: [:create, :destroy]
      member do
        put 'mark'
        delete 'cancel_mark'
        put 'up_vote'
        put 'down_vote'
        delete 'cancel_vote'
      end
    end
    resources :comments, only: [:create, :destroy]
    member do
      put 'favorite'
      delete 'cancel_favorite'
      put 'up_vote'
      put 'down_vote'
      delete 'cancel_vote'
    end
  end

  devise_for :users

  root to: 'questions#index'
end
