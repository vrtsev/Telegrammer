# frozen_string_literal: true

require './config/environment.rb'

Sidekiq::Web.set(:sessions, { key: 'rack.session.sidekiqui', path: '/' })

run Sidekiq::Web
