# frozen_string_literal: true

Imprint::Engine.routes.draw do
  get 'render/:token', to: 'renders#show'
end
