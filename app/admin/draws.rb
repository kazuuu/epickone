ActiveAdmin.register Draw do
  form :html => { :enctype => "multipart/form-data" }  do |f|
    f.inputs "Draws", :multipart => true do
      f.input :avatar, :as => :file, :multipart => true, :label => "Avatar", :hint => f.object.avatar.nil? ? f.template.content_tag(:span, "No Image Yet") : f.template.image_tag(f.object.avatar.url(:thumb)) 
      f.input :avatar_delete, :as=>:boolean, :required => false, :label => 'Remove image' 

      f.input :title
      f.input :min_users
      f.input :max_users
      f.input :localization
      f.input :price
      f.input :date_due
      f.input :date_start
      f.input :description, :as => :text
      f.input :user_id, :as => :select, :collection => User.all.map {|u| [u.email, u.id]}, :include_blank => false
    end
        
    f.has_many :questions do |q|
      if !q.object.id.nil?
        q.input :_destroy, :as => :boolean, :label => "delete"
      end
      q.inputs "Question", :multipart => true do
        q.input :title         
        q.input :description         
        q.input :order         
        q.input :type         
        q.input :avatar, :as => :file, :multipart => true, :label => "Avatar", :hint => q.object.avatar.nil? ? q.template.content_tag(:span, "No Image Yet") : q.template.image_tag(q.object.avatar.url(:thumb)) 
        q.input :avatar_delete, :as=>:boolean, :required => false, :label => 'Remove image' 
      end


      q.has_many :answers do |a|
        if !a.object.id.nil?
          a.input :_destroy, :as => :boolean, :label => "delete"
        end
        a.inputs "Answer", :multipart => true do
          a.input :title
          a.input :description
          a.input :iscorrect
          a.input :order
          a.input :avatar, :as => :file, :multipart => true, :label => "Avatar", :hint => a.object.avatar.nil? ? a.template.content_tag(:span, "No Image Yet") : a.template.image_tag(a.object.avatar.url(:thumb)) 
          a.input :avatar_delete, :as=>:boolean, :required => false, :label => 'Remove image' 
        end
      end
    end
             
    f.buttons
  end    

  show :title => :title do |draw|
    attributes_table do
      row :id
      row :title
    end
    div :class => "panel" do
      h3 "Questions"
      if draw.questions and draw.questions.count > 0
        div :class => "panel_contents" do
          div :class => "attributes_table" do
            table do
              tr do
                th do
                  "Questions"
                end
              end
              tbody do
                
                draw.questions.each do |question|
                  div :class => "panel_contents" do
                    div :class => "attributes_table" do
                      table do
                        tr do
                          th do
                            question.title
                          end
                        end
                        tbody do

                          question.answers.each do |answer|
                            tr do
                              td do
                                answer.title
                              end
                            end
                          end
                        end
                      end
                    end
                  end
                end
              end
            end
          end
        end
      else
        h3 "No comments available"
      end
      
      div :class => "panel" do
        h3 "Drawships"
        if draw.drawships and draw.drawships.count > 0
          div :class => "panel_contents" do
            div :class => "attributes_table" do
              table do
                tr do
                  th do
                    "user_id"
                  end
                  th do
                    "picked_number"
                  end
                end
                tbody do
                  draw.drawships.each do |drawship|
                    div :class => "panel_contents" do
                      div :class => "attributes_table" do
                        table do
                          tr do
                            th do
                              drawship.user_id
                            end
                            th do
                              drawship.picked_number
                            end
                          end
                        end
                      end
                    end
                  end
                end
              end
            end
          end
        else
          h3 "No drawships available"
        end

      end

    end
  end



end
