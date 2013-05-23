ActiveAdmin.register Question do
  form :html => { :enctype => "multipart/form-data" }  do |q|
    q.inputs "Question", :multipart => true do
      q.input :quiz_id, :as => :select, :collection => Quiz.all.map {|u| [u.title, u.id]}, :include_blank => false
      q.input :avatar, :as => :file, :multipart => true, :label => "Avatar", :hint => q.object.avatar.nil? ? q.template.content_tag(:span, "No Image Yet") : q.template.image_tag(q.object.avatar.url(:thumb)) 
      q.input :avatar_delete, :as=>:boolean, :required => false, :label => 'Remove image' 

      q.globalize_inputs :translations do |qt|
        qt.inputs do
          qt.input :title
          qt.input :description, :as => :text
          qt.input :locale, :as => :hidden
        end
      end      
      q.input :order         
      q.input :style         
      
      q.has_many :answers do |a|
        if !a.object.id.nil?
          a.input :_destroy, :as => :boolean, :label => "delete"
        end
        a.inputs "Answer", :multipart => true do
          a.inputs "Answer", :multipart => true do
            a.input :avatar, :as => :file, :multipart => true, :label => "Avatar", :hint => a.object.avatar.nil? ? a.template.content_tag(:span, "No Image Yet") : a.template.image_tag(a.object.avatar.url(:thumb)) 
            a.input :avatar_delete, :as=>:boolean, :required => false, :label => 'Remove image' 

            a.globalize_inputs :translations do |at|
              at.inputs do
                at.input :answer_text
                at.input :description, :as => :text

                at.input :locale, :as => :hidden
              end
            end      

            a.input :iscorrect
            a.input :order
          end
        end
      end
    end
             
    q.buttons
  end    
end