Rails.application.routes.draw do

  devise_for :users
  # Home page should be pages#home
  root to: 'pages#home'

  # Root to profile page
  get 'pages/profile' => 'pages#profile', as: 'profile'

  # As a user, I want to see all available teachers, see indivudal profiles and create a new teacher profile for me
  # As a teacher, I want to edit my teacher profile
  resources 'bookings', only:[:new, :create, :index, :show, :destroy]
  patch 'bookings/:id/approve', to: 'bookings#approve', as: :approve_booking
  patch 'bookings/:id/cancel', to: 'bookings#cancel', as: :cancel
  post 'bookings/:id/complete', to: 'bookings#complete', as: :complete


  resources 'teachers', only:[:index, :show, :edit, :update, :new, :create, :destroy] do
     resources 'bookings', only:[:new, :create, :destroy]

    # As a user, I want to see all my bookings create a new booking and delete it if I no longer want the session
    # As a teacher, I want to see all my bookings, edit their status and delete them
    # As a teacher, I want to show all my skills, add new skills and delete skills I no longer possess
    resources 'teacher_skills', only:[:index, :new, :create, :destroy]
  end

end
