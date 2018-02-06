# frozen_string_literal: true

Rails.application.routes.draw do
  root to: 'application#index'
  get :source, to: 'application#source', as: :source_page
  get :target, to: 'application#target', as: :target_page
end
