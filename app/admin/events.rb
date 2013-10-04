ActiveAdmin.register Event do
  filter :enable, :as => :select

  form :html => { :enctype => "multipart/form-data" }  do |f|
    f.inputs "Event", :multipart => true do
      f.input :avatar, :as => :file, :multipart => true, :label => "Avatar", :hint => f.object.avatar.nil? ? f.template.content_tag(:span, "No Image Yet") : f.template.image_tag(f.object.avatar.url(:thumb)) 
      f.input :avatar_delete, :as=>:boolean, :required => false, :label => 'Remove image' 
      f.input :category_id, :as => :select, :collection => Category.all.map {|u| [u.title, u.id]}, :include_blank => true
      f.input :quiz_id, :as => :select, :collection => Quiz.all.map {|u| [u.title, u.id]}, :include_blank => true
      f.input :enable
      f.input :start_date
      f.input :end_date
      f.input :join_min
      f.input :join_max
      f.input :covering_area
      
      f.globalize_inputs :translations do |lf|
        lf.inputs do
          lf.input :title
          lf.input :promoter
          lf.input :headline
          lf.input :prize_title
          lf.input :description, :as => :text
          lf.input :instruction, :as => :text
          
          lf.input :locale, :as => :hidden
        end
      end
    end 
    f.has_many :photos do |p|
      if !p.object.id.nil?
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
 
  index do 
    column :id
    column :promoter
    column :title
    column("Start Date", :sortable => :start_date) { |task| task.start_date? ? l(task.start_date, :format => :default) : '-' }    
    column("End Date", :sortable => :end_date) { |task| task.end_date? ? l(task.end_date, :format => :default) : '-' }
    column :category, :sortable => :category_id
    column :quiz, :sortable => :quiz_id
    default_actions
  end

  show do |event|
    attributes_table do
      row :id
    end
  end
end
