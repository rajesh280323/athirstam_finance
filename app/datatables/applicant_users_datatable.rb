class ApplicantUsersDatatable < AjaxDatatablesRails::ActiveRecord
extend Forwardable
 def_delegators :@view, :link_to, :applicant_users_path


  def initialize(params, opts = {})
    @view = opts[:view_context]
    super
  end
  def view_columns
    @view_columns ||= {
      id: { source: "ApplicantUser.id" },
      first_name: { source: "ApplicantUser.first_name" },
      last_name: { source: "ApplicantUser.last_name" },
      email: { source: "ApplicantUser.email" },
      phone_number: { source: "ApplicantUser.phone_number" },
      aadhar_number: { source: "ApplicantUser.aadhar_number" },
     actions: { searchable: false, orderable: false }
      
    }
  end

  def data
    records.map do |record|
      {
        # name: link_to("<span class='highlight' style='color:blue'>#{record.name}</span>".html_safe, applicant_users_path(record), class: 'anchor-class'),
        id: record.id,
        first_name: record.first_name,
        last_name: record.last_name,
        email: record.email,
        phone_number: record.phone_number,
        aadhar_number: record.aadhar_number,
         actions: link_to('View', "/applicant_users/#{record.id}")+ " " +
         link_to('Edit', "/applicant_users/#{record.id}/edit")
       }
     end
  end
  
 def get_raw_records
    ApplicantUser.all
  end
  
end