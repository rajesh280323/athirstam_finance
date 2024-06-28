class LoansController < ApplicationController
  before_action :set_loan, only: [:show, :edit, :update, :destroy]

  def index
	respond_to do |format|
	  format.html
	  format.json { render json: LoansDatatable.new(params, view_context: view_context) }
	end
  end

  def show
  end

  def new
    @loan = Loan.new
  end

  def edit
  end

  def create
    puts "-------------------------------"
    @loan = Loan.new(loan_params)
    respond_to do |format|
      if @loan.save
        format.html { redirect_to @loan, notice: 'Loan was successfully created.' }
        format.json { render :show, status: :created, location: @loan }
      else
        format.html { render :new }
        format.json { render json: @loan.errors, status: :unprocessable_entity }
      end
    end
  end

   def update
    respond_to do |format|
      if @loan.update(loan_params)
        format.html { redirect_to loans_url, notice: 'Loan was successfully updated.' }
      format.json { head :no_content }
        
        # format.json { render :show, status: :ok, location: @loan }
      else
        format.html { render :edit }
        format.json { render json: @loan.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @loan.destroy
    respond_to do |format|
      format.html { redirect_to loans_url, notice: 'Loan was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def set_loan
    @loan = Loan.find(params[:id])
  end

  def loan_params
    params.require(:loan).permit(:name)
  end
end
