class WelcomeController < ApplicationController
  def show
    respond_to do |format|
      format.html { render :layout => 'welcome' }
    end
  end
end