class UploadsController < ApplicationController

  def index
    Import.delete_all

    if params[ :commit ] =~ /Save/
      @user = User.find(params[:id])
      @user.uploader = params[:user][:uploader]
      @user.save!
      @user.import!
    else
      @user = User.first
      respond_to do |format|
        format.html
      end
    end

  end

end
