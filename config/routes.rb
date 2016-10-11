Rails.application.routes.draw do
  resources :agents
  resources :customers
  resources :tickets, only: [:index, :show, :create]
  resources :ticket_items, only: [:create]

  namespace :agent do
    post 'sessions' => 'sessions#create'
    post 'delete_session' => 'sessions#destroy'

    resources :tickets, only: [:index, :show, :update] do
      member do
        patch :update_state
      end
    end

    resources :ticket_items, only: [:create]
  end

  namespace :admin do
    post 'sessions' => 'sessions#create'
    post 'delete_session' => 'sessions#destroy'

    resources :customers
    resources :agents
    resources :tickets
  end

  post 'sessions' => 'sessions#create'
  post 'delete_session' => 'sessions#destroy'

  get 'pdf/closed_tickets_last_month' => 'agent/report#closed_tickets_last_month'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
