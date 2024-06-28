class LoansDatatable < AjaxDatatablesRails::ActiveRecord
extend Forwardable
 def_delegators :@view, :link_to, :loans_path


  def initialize(params, opts = {})
    @view = opts[:view_context]
    super
  end
  def view_columns
    @view_columns ||= {
      id: { source: "Loan.id" },
      loan_amount: { source: "Loan.loan_amount" },
      roi: { source: "Loan.roi" },
      tenure_weeks: { source: "Loan.tenure_weeks" },
      disbursement_amount: { source: "Loan.disbursement_amount" },
      weekly_collection_amount: { source: "Loan.weekly_collection_amount" },
      disbursement_date: { source: "Loan.disbursement_date" },
      weekly_collection_date: { source: "Loan.weekly_collection_date" },
      first_ewi_date: { source: "Loan.first_ewi_date" },
      loan_closing_date: { source: "Loan.loan_closing_date" },
      actions: { searchable: false, orderable: false }
      
    }
  end

  def data
    records.map do |record|
      {
        # name: link_to("<span class='highlight' style='color:blue'>#{record.name}</span>".html_safe, loans_path(record), class: 'anchor-class'),
        id: record.id,
        loan_amount: record.loan_amount,
        roi: record.roi,
        tenure_weeks: record.tenure_weeks,
        disbursement_amount: record.disbursement_amount,
        weekly_collection_amount: record.weekly_collection_amount,
        disbursement_date: record.disbursement_date,
        weekly_collection_date: record.weekly_collection_date,
        first_ewi_date: record.first_ewi_date,
        loan_closing_date: record.loan_closing_date,
         actions: link_to('View', "/loans/#{record.id}")+ " " +
         link_to('Edit', "/loans/#{record.id}/edit")
       }
     end
  end
  
 def get_raw_records
    Loan.all
  end
  
end
