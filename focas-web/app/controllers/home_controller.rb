class HomeController < ApplicationController
  def index
    require Rails.root.join('app', 'assets', 'quotes').to_s
    @quotes = QUOTES
  end
end
