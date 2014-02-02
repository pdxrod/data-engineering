class UploadsController < ApplicationController

  def index
    @user = User.first

    respond_to do |format|
      format.html
    end
  end

end
