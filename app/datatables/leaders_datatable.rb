class LeadersDatatable < AjaxDatatablesRails::ActiveRecord
extend Forwardable
 def_delegators :@view, :link_to, :leaders_path, :leader_path, :edit_leader_path


  def initialize(params, opts = {})
    @view = opts[:view_context]
    super
  end
  def view_columns
    @view_columns ||= {
      id: { source: "Leader.id" },
      first_name: { source: "Leader.first_name" },
      last_name: { source: "Leader.last_name" },
      email: { source: "Leader.email" },
      phone_number: { source: "Leader.phone_number" },
      aadhar_number: { source: "Leader.aadhar_number" },
     actions: { searchable: false, orderable: false }
      
    }
  end

  def data
    records.map do |record|
      {
        # name: link_to("<span class='highlight' style='color:blue'>#{record.name}</span>".html_safe, leaders_path(record), class: 'anchor-class'),
        id: record.id,
        first_name: record.first_name,
        last_name: record.last_name,
        email: record.email,
        phone_number: record.phone_number,
        aadhar_number: record.aadhar_number,
        actions: link_to('View', leader_path(record), class: "btn btn-primary btn-sm") + " " + link_to('Edit', edit_leader_path(record), class: "btn btn-info btn-sm")
         # + " " + link_to("Delete", leader_path(record), class: "btn btn-danger btn-sm", method: :delete, data: { confirm: "Are you sure?" })
         # actions: link_to('View', "/leaders/#{record.id}")+ " " +
         # link_to('Edit', "/leaders/#{record.id}/edit")
       }
     end
  end
  
 def get_raw_records
    Leader.all
  end
  
end