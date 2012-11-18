ActiveAdmin.register Draw do
  form :html => { :enctype => "multipart/form-data" }  do |f|
    f.inputs "Draws", :multipart => true do
      f.input :avatar, :as => :file, :multipart => true, :label => "Avatar", :hint => f.object.avatar.nil? ? f.template.content_tag(:span, "No Image Yet") : f.template.image_tag(f.object.avatar.url(:thumb)) 
      f.input :avatar_delete, :as=>:boolean, :required => false, :label => 'Remove image' 

      f.input :join_type
      f.input :title
      f.input :join_min
      f.input :join_max
      f.input :localization
      f.input :price_original
      f.input :price_ticket
      f.input :date_due
      f.input :date_start
      f.input :site_position
      f.input :description, :as => :text
      f.input :instruction, :as => :text
      f.input :user_id, :as => :select, :collection => User.all.map {|u| [u.email, u.id]}, :include_blank => false
    end
    
    f.has_many :draw_images do |di|
      if !di.object.id.nil?
        di.input :_destroy, :as => :boolean, :label => "delete"
      end
      di.inputs "DrawImages", :multipart => true do
        di.input :image_type
        di.input :image, :as => :file, :multipart => true, :label => "Image", :hint => di.object.image.nil? ? di.template.content_tag(:span, "No Image Yet") : di.template.image_tag(di.object.image.url(:thumb)) 
        di.input :image_delete, :as=>:boolean, :required => false, :label => 'Remove image' 
      end
    end
    
        
    f.has_many :questions do |q|
      if !q.object.id.nil?
        q.input :_destroy, :as => :boolean, :label => "delete"
      end
      q.inputs "Question", :multipart => true do
        q.input :title         
        q.input :description         
        q.input :position         
        q.input :style         
        q.input :avatar, :as => :file, :multipart => true, :label => "Avatar", :hint => q.object.avatar.nil? ? q.template.content_tag(:span, "No Image Yet") : q.template.image_tag(q.object.avatar.url(:thumb)) 
        q.input :avatar_delete, :as=>:boolean, :required => false, :label => 'Remove image' 
      end


      q.has_many :answers do |a|
        if !a.object.id.nil?
          a.input :_destroy, :as => :boolean, :label => "delete"
        end
        a.inputs "Answer", :multipart => true do
          a.input :text
          a.input :description
          a.input :iscorrect
          a.input :position
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
                                answer.text
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
        h3 "Participants Completed"
        if draw.cartitems and draw.cartitems.count > 0
          div :class => "panel_contents" do
            div :class => "attributes_table" do
              table do
                tr do
                  th do
                    "user_id"
                  end
                  th do
                    "purchased_at"
                  end
                  th do
                    "picked_number"
                  end
                end
                tbody do
                  draw.cartitems.each do |cartitem|
                    div :class => "panel_contents" do
                      div :class => "attributes_table" do
                        table do
                          tr do
                            th do
                              cartitem.cart.user_id
                            end
                            th do
                              cartitem.cart.purchased_at
                            end
                            th do
                              cartitem.picked_number
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
          h3 "No cartitem available"
        end

      end

    end
  end



end

