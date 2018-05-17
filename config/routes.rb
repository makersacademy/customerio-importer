Rails.application.routes.draw do
  get '/opt-in', to: 'contacts#opt_in'
  get '/opt-out', to: 'contacts#opt_out'
  get '/error', to: 'contacts#error'

  root to: redirect('https://www.makersacademy.com')
end
