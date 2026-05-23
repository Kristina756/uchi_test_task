Rails.application.routes.draw do
  post "/students", to: "students#create"
  delete "/students/:user_id", to: "students#destroy"

  resources :schools, only: [] do
    resources :classes, only: [ :index ] do
      resources :students, only: [ :index ]
    end
  end
end
