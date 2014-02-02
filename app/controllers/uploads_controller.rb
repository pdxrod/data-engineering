class UploadsController < ApplicationController

  def index
    if params[ :commit ] == 'Save'
      @user = User.find(params[:id])
      file = params[:user][:uploader]
      contents = file.read
      @user.save!
      @user.import!(contents: contents)
      file.close
    else
      Import.delete_all
      @user = User.first
      respond_to do |format|
        format.html
      end
    end
  end

end
