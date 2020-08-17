# frozen_string_literal: false

require 'pry'
require 'zeitwerk'
require 'hanami/view'
require 'hanami/router'
require 'hanami/controller'

loader = Zeitwerk::Loader.new
loader.push_dir('./apps/web/controllers')
loader.push_dir('./apps/web/templates')
loader.push_dir('./lib/operations')
loader.setup

Hanami::View.configure do
  root './apps/web/templates'
  layout :application
end
Hanami::View.load!

require_relative 'routes.rb'