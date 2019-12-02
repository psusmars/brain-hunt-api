Rails.application.routes.draw do
  resources :reading_sessions do
    resources :brain_samples
  end

  post 'process_txt_file', to: 'reading_sessions#process_txt_file'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
