class HomeController < ApplicationController
  def shopping_list
    render partial: 'home/modal_shopping_list'
  end
end
