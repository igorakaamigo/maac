require 'rubygems'

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def index
    render json: Hash[
      Gem::Specification.map { |s| [s.name, s.version.to_s] }
    ]
  end

  def source; end

  def target; end
end
