Rails.application.routes.draw do
  get :source, to: 'application#source', as: :source_page
  get :target, to: 'application#target', as: :target_page
end
