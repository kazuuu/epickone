ActiveAdmin.register Product do
  form :html => { :enctype => "multipart/form-data" }  do |f|
    f.inputs "Products", :multipart => true do
      f.input :avatar, :as => :file, :multipart => true, :label => "Avatar", :hint => f.object.avatar.nil? ? f.template.content_tag(:span, "No Image Yet") : f.template.image_tag(f.object.avatar.url(:thumb)) 
      f.input :avatar_delete, :as=>:boolean, :required => false, :label => 'Remove image' 
      f.input :order
      f.input :price_original
      f.input :category_id, :as => :select, :collection => Category.all.map {|u| [u.title, u.id]}, :include_blank => false
      f.globalize_inputs :translations do |lf|
        lf.inputs do
          lf.input :title
          lf.input :description, :as => :text

          lf.input :locale, :as => :hidden
        end
      end
    end

    f.has_many :photos do |p|
      if !p.object_id.nil?
        p.input :_destroy, :as => :boolean, :label => "delete"
      end
      p.inputs "Images", :multipart => true do
        p.input :image_type
        p.input :image, :as => :file, :multipart => true, :label => "Image", :hint => p.object.image.nil? ? p.template.content_tag(:span, "No Image Yet") : p.template.image_tag(p.object.image.url(:thumb)) 
        p.input :image_delete, :as=>:boolean, :required => false, :label => 'Remove image' 
      end
    end
    
    
    f.buttons
  end    
end

