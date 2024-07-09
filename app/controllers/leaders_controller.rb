require 'prawn'
require 'fileutils'
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
    @area = Area.find_by(id: params[:area])
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

 def generate_pdf
    leader = Leader.find_by(id: params[:id])
    generate_pdf_filepath = "#{Rails.root}/storage/agreement/#{leader.id}"
    FileUtils.mkdir_p(File.dirname(generate_pdf_filepath))
    # Now create generate_pdf_filepath if it doesn't exist
    Dir.mkdir(generate_pdf_filepath) unless Dir.exist?(generate_pdf_filepath)
    generate_pdf_filepath_filename = "#{generate_pdf_filepath}/loan_agreement_#{Time.now.strftime("%d_%m_%Y")}.pdf"

    Prawn::Document.generate(generate_pdf_filepath_filename, page_size: 'A4', margin: [30, 25, 30, 25]) do |pdf|
        puts leader_loan = leader.loans.where(status: :active).first

        if leader_loan.present?
          new_page = ''
          applicant_name = "#{leader.first_name}.#{leader.last_name}"
          phone_number = leader.phone_number
          property = leader.property
          loan_amount = leader_loan.loan_amount
          collection_amount = leader_loan.weekly_collection_amount
          no_of_weeks = leader.property
          current_address = leader.property
          gurantee_name = "Priya S"
          gurantee_phone_number = "7305539172"
          gurantee_area = ""
          write_to_pdf(new_page,pdf,applicant_name,phone_number,property,loan_amount,collection_amount,no_of_weeks,current_address,gurantee_name,gurantee_phone_number,gurantee_area)
        end
       leader.applicant_users.each_with_index do |app_user, index|
         puts user_loan = app_user.loans.where(status: :active).first
          if user_loan.present?
              new_page = true
              applicant_name = "#{app_user.first_name}.#{app_user.last_name}"
              phone_number = app_user.phone_number
              property = app_user.property
              loan_amount = user_loan.loan_amount
              collection_amount = user_loan.weekly_collection_amount
              no_of_weeks = user_loan.property
              current_address = app_user.property
              gurantee_name = "#{app_user.leader.first_name}.#{app_user.leader.last_name}"
              gurantee_phone_number = app_user.leader.phone_number
              gurantee_area = app_user.leader.area.name
            write_to_pdf(new_page,pdf,applicant_name,phone_number,property,loan_amount,collection_amount,no_of_weeks,current_address,gurantee_name,gurantee_phone_number,gurantee_area)
          end
       end
    end

    send_file generate_pdf_filepath_filename, type: 'application/pdf', disposition: 'attachment'
  end


  def write_to_pdf(new_page,pdf,applicant_name,phone_number,property,loan_amount,collection_amount,no_of_weeks,current_address,gurantee_name,gurantee_phone_number,gurantee_area)
       pdf.start_new_page if new_page == true
         pdf.move_down 20
         pdf.font_size 20
         pdf.text "ATHIRSTAM FINANCE", style: :bold, align: :center
         pdf.move_down 30
         pdf.font_size 11
          pdf.text "1. Applicant's name                   : #{applicant_name}", indent_paragraphs: 13
          pdf.move_down 18
          pdf.text "2. Husband/Father's name        : ", indent_paragraphs: 13
          pdf.move_down 18
          pdf.text "3. Applicant's Aadhaar number : ", indent_paragraphs: 13
          pdf.move_down 18
          pdf.text "4. Family card number               : ", indent_paragraphs: 13
          pdf.move_down 18
          pdf.text "5. Phone number                       : #{phone_number}", indent_paragraphs: 13
          pdf.move_down 18
          pdf.text "6. Residence status                   : #{property}", indent_paragraphs: 13
          pdf.move_down 18
          pdf.text "7. Loan amount                          : #{loan_amount}", indent_paragraphs: 13
          pdf.move_down 18
          pdf.text "8. Weekly collection amount      : #{collection_amount}", indent_paragraphs: 13
          pdf.move_down 18
          pdf.text "9. Number of weeks                   : #{no_of_weeks}", indent_paragraphs: 13
          pdf.move_down 18
          pdf.text "10. Current address                     : #{current_address}", indent_paragraphs: 8
          pdf.move_down 18
          pdf.text "11. I agree to repay this loan in due installments subject to their company's legal plans.", indent_paragraphs: 8
          pdf.move_down 35
          pdf.text "Applicant's Husband Signature                                                                      Applicant's Signature", indent_paragraphs: 27
          pdf.move_down 20
          pdf.text "12. Here are the details about the guarantor ,", indent_paragraphs: 8
          pdf.move_down 8
          pdf.text "I.   Leader Name        : #{gurantee_name}", indent_paragraphs: 29
          pdf.move_down 8
          pdf.text "II.  Husband Name     : ", indent_paragraphs: 28
          pdf.move_down 8
          pdf.text "III. Aadhaar Number   : ", indent_paragraphs: 28
          pdf.move_down 8
          pdf.text "IV.  Phone Number     : #{gurantee_phone_number}", indent_paragraphs: 28
          pdf.move_down 20
          pdf.text "13. In case the applicant fails to repay the loan in installments, I hereby agree to draw a bank check signed ", indent_paragraphs: 8
          pdf.move_down 5
          pdf.formatted_text [
            { text: "by me as chairman of the committee " },
            { text: "Mrs. #{gurantee_name}", styles: [:bold] } ,        
            { text: " through the bank and pay the" }         
          ], indent_paragraphs: 27
          pdf.move_down 5
          pdf.text " outstanding loan amount and interest as per the legal plans of the company.", indent_paragraphs: 27
          pdf.move_down 30
          pdf.text "Place: #{gurantee_area}", indent_paragraphs: 27
          pdf.move_down 10
          pdf.text "Date : #{Time.now.strftime("%d-%m-%Y")}", indent_paragraphs: 27
          pdf.move_down 20
          pdf.text "_________________________________________________________________________________________", style: :bold
          pdf.move_down 40
          pdf.text "Leader Signature                                                                                    Company Manager Signature", indent_paragraphs: 27
          pdf.bounding_box([350, 705], width: 90, height: 100) do
            pdf.stroke_bounds
          end
           pdf.bounding_box([445, 705], width: 90, height: 100) do
            pdf.stroke_bounds
          end
         pdf.stroke_bounds
         pdf.move_down 18
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
