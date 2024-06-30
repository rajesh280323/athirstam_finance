class LoansController < ApplicationController
  before_action :set_loan, only: [:show]

  def index
	respond_to do |format|
	  format.html
	  format.json { render json: LoansDatatable.new(params, view_context: view_context) }
	end
  end

  # def show
  # end

  def new
    @loan = Loan.new
    @leader_id = params[:leader_id]
    @au_id = params[:au_id]
    puts "------------------------#{@leader_id}"
  end

  # def edit
  # end

  def create
    puts "-------------------------------"
    @loan = Loan.new(loan_params)
    # respond_to do |format|
      if @loan.save
        redirect_to "/leaders/#{loan_params[:leader_id]}", notice: 'Loan was successfully created.' if loan_params[:leader_id].present?
        redirect_to "/applicant_users/#{loan_params[:applicant_user_id]}", notice: 'Loan was successfully created.' if loan_params[:applicant_user_id].present?
        # format.html { redirect_to @loan, notice: 'Loan was successfully created.' }
        # format.json { render :show, status: :created, location: @loan }
      else
        redirect_to "/loans/new?leader_id:#{loan_params[:leader_id]}", notice: 'Loan was not created.' if loan_params[:leader_id].present?
        redirect_to "/loans/?au_id:#{loan_params[:applicant_user_id]}", notice: 'Loan was not created.' if loan_params[:applicant_user_id].present?
        # format.html { render :new }
        # format.json { render json: @loan.errors, status: :unprocessable_entity }
      end
    # end
  end

  #  def update
  #   respond_to do |format|
  #     if @loan.update(loan_params)
  #       format.html { redirect_to loans_url, notice: 'Loan was successfully updated.' }
  #     format.json { head :no_content }
        
  #       # format.json { render :show, status: :ok, location: @loan }
  #     else
  #       format.html { render :edit }
  #       format.json { render json: @loan.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  # def destroy
  #   @loan.destroy
  #   respond_to do |format|
  #     format.html { redirect_to loans_url, notice: 'Loan was successfully destroyed.' }
  #     format.json { head :no_content }
  #   end
  # end

  private

  def set_loan
    @loan = Loan.find(params[:id])
  end

  def loan_params
    params.require(:loan).permit(:loan_amount, :roi, :tenure_weeks, :disbursement_amount, :disbursement_date, :weekly_collection_amount, :weekly_collection_date, :first_ewi_date, :loan_closing_date, :leader_id, :applicant_user_id )
  end
end
