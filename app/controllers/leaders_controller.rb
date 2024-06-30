class LeadersController < ApplicationController
  before_action :set_leader, only: [:show, :edit, :update]

  def index
	respond_to do |format|
	  format.html
	  format.json { render json: LeadersDatatable.new(params, view_context: view_context) }
	end
  end
 
  def show  
    @leader = Leader.find_by(id: params[:id])
    @leader_loan = @leader.loans.first
  end

  def new
    @title = "New Leader"
    @leader = Leader.new
    @properties = ["Rental","Owned","Leased"]
  end

  def edit
    @title = "Edit Leader"
    @properties = ["Rental","Owned","Leased"]
  end

  def create
    @leader = Leader.new(leader_params)
    respond_to do |format|
      if @leader.save
        format.html { redirect_to @leader, notice: 'Leader was successfully created.' }
        format.json { render :show, status: :created, location: @leader }
      else
        format.html { render :new }
        format.json { render json: @leader.errors, status: :unprocessable_entity }
      end
    end
  end

   def update
    respond_to do |format|
      if @leader.update(leader_params)
        format.html { redirect_to leaders_url, notice: 'Leader was successfully updated.' }
      format.json { head :no_content }
        
        # format.json { render :show, status: :ok, location: @leader }
      else
        format.html { render :edit }
        format.json { render json: @leader.errors, status: :unprocessable_entity }
      end
    end
  end

  # def destroy
  #   @leader.destroy
  #   respond_to do |format|
  #     format.html { redirect_to leaders_url, notice: 'Leader was successfully destroyed.' }
  #     format.json { head :no_content }
  #   end
  # end

  private

  def set_leader
    @leader = Leader.find(params[:id])
  end

  def leader_params
    params.require(:leader).permit(:first_name, :last_name, :email, :phone_number, :aadhar_number, :area_id, :property)
  end
end
