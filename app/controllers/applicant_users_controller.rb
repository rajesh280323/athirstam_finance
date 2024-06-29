class ApplicantUsersController < ApplicationController
  before_action :set_applicant_user, only: [:show, :edit, :update, :destroy]

 def index
	 respond_to do |format|
	  format.html
	  format.json { render json: ApplicantUsersDatatable.new(params, view_context: view_context) }
   end
 end

  def show
    @applicant_user = ApplicantUser.find_by(id: params[:id])
  end

  def new
    @applicant_user = ApplicantUser.new
  end

  def edit
  end

  def create
    @applicant_user = ApplicantUser.new(applicant_user_params)
    respond_to do |format|
      if @applicant_user.save
        format.html { redirect_to @applicant_user, notice: 'ApplicantUser was successfully created.' }
        format.json { render :show, status: :created, location: @applicant_user }
      else
        format.html { render :new }
        format.json { render json: @applicant_user.errors, status: :unprocessable_entity }
      end
    end
  end

   def update
    respond_to do |format|
      if @applicant_user.update(applicant_user_params)
        format.html { redirect_to applicant_users_url, notice: 'ApplicantUser was successfully updated.' }
      format.json { head :no_content }
        
        # format.json { render :show, status: :ok, location: @applicant_user }
      else
        format.html { render :edit }
        format.json { render json: @applicant_user.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @applicant_user.destroy
    respond_to do |format|
      format.html { redirect_to applicant_users_url, notice: 'ApplicantUser was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def set_applicant_user
    @applicant_user = ApplicantUser.find(params[:id])
  end

  def applicant_user_params
    params.require(:applicant_user).permit(:first_name, :last_name, :email, :phone_number, :aadhar_number, :area, :leader_id)
  end
end

