ActiveAdmin.register Category do
  form :html => { :enctype => "multipart/form-data" }  do |f|
    f.inputs "Category", :multipart => true do
      f.input :parent_id, :as => :select, :collection => Category.all.map {|u| [u.title, u.id]}, :include_blank => false
      f.input :sort_order
      f.input :join_type
      
      f.globalize_inputs :translations do |lf|
        lf.inputs do
          lf.input :title
          lf.input :description, :as => :text
          lf.input :locale, :as => :hidden
        end
      end
    end 
    f.buttons
  end
end