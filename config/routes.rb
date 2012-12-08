Screenshot::Application.routes.draw do
  match "/" => "home#screenshot", :as => :screenshot, :via => :post
  root :to => "home#index"
end
