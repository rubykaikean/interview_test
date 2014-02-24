class HomeController < ApplicationController
	

  def index
  	@drawings = Drawing.order('id DESC')
  	
  end




end
