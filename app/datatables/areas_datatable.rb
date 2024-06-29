class AreasDatatable < AjaxDatatablesRails::ActiveRecord
extend Forwardable
 def_delegators :@view, :link_to, :areas_path

  def_delegators :@view, :link_to, :edit_area_path, :area_path

  def initialize(params, opts = {})
    @view = opts[:view_context]
    super
  end
  def view_columns
    @view_columns ||= {
      id: { source: "Area.id" },
      name: { source: "Area.name" },
      actions: { searchable: false, orderable: false }
    }
  end

   def data
     records.map do |record|
        {
          id: record.id,
          # name: link_to("<span class='highlight' style='color:blue'>#{record.name}</span>".html_safe, "/areas/#{record.id}", class: 'anchor-class'),
          name: record.name,
          actions: link_to('View', area_path(record), class: "btn btn-primary btn-sm") + " " + link_to('Edit', edit_area_path(record), class: "btn btn-info btn-sm")
        }
    end
  end
 def get_raw_records
    Area.all
  end
  
end
