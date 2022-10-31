Rails.application.routes.draw do
  resources :students
  resources :proses
  resources :kataas
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  post "/mentors/register", to: "auth#register"
  post "/mentors/login", to: "auth#login"
  post "/students/register", to: "students#register"
  post "/students/login", to: "students#login"
  resources "contacts", only: [ :create]
  resources "assessments"
  resources "quizzes"
  resources "mentors", only: [:show]
end
