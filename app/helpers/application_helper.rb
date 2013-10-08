module ApplicationHelper
  def link_to_add_fields(name, f, association)
    new_object = f.object.send(association).klass.new
    id = new_object.object_id
    fields = f.fields_for(association, new_object, child_index: id) do |builder|
      render(association.to_s.singularize + "_fields", f: builder)
    end
    link_to(name, '#', class: "add_fields", data: {id: id, fields: fields.gsub("\n", "")})
  end
  # Returns the full title on a per-page basis.
  def full_title(page_title)
    base_title = "ePick One"
    if page_title.empty?
      base_title
    else
      "#{base_title} | #{page_title}"
    end
  end
  def javascript(*files)
    content_for(:head) { javascript_include_tag(*files) }
  end

  def stylesheet(*files)
    content_for(:head) { stylesheet_link_tag(*files) }
  end
  def cities_collection(user, cities)
    "".tap do |pc| 
      # to generate the markup for collection we need a dummy form
      simple_form_for(user) do |f| 
        pc << f.association(:city, collection: cities, :prompt => "Selecione-", :wrapper_html => {:id => 'cities-select-list',  "city_phone_code_url" => update_city_phone_code_users_path() })
      end
    end
  end
  
  def city_phone_code(city)
    "<label id='city_phone_code' style='display:inline;'>(" + city.phone_code.to_s + ")</label>"
  end
end
