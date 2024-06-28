class ApplicantUsersController < ApplicationController
	 def index
	respond_to do |format|
	  format.html
	  format.json { render json: ApplicantUsersDatatable.new(params, view_context: view_context) }
	end
  end
 

  def show
    @applicant_user = ApplicantUser.find_by(id: params[:id])
  end
end
