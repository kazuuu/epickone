ActiveAdmin.register Category do
  form :html => { :enctype => "multipart/form-data" }  do |f|
    f.inputs "Credits", :multipart => true do
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