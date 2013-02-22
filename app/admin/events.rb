ActiveAdmin.register Event do
  form :html => { :enctype => "multipart/form-data" }  do |f|
    f.inputs "Events", :multipart => true do
      f.input :avatar, :as => :file, :multipart => true, :label => "Avatar", :hint => f.object.avatar.nil? ? f.template.content_tag(:span, "No Image Yet") : f.template.image_tag(f.object.avatar.url(:thumb)) 
      f.input :avatar_delete, :as=>:boolean, :required => false, :label => 'Remove image' 

      f.globalize_inputs :translations do |lf|
        lf.inputs do
          lf.input :title
          lf.input :headline
          lf.input :description, :as => :text
          lf.input :instruction, :as => :text

          lf.input :locale, :as => :hidden
        end
      end
      f.input :enable
      f.input :join_type
      f.input :site_position
      f.input :date_due
      f.input :date_start
      f.input :price_ticket

      f.input :join_min
      f.input :join_max
      f.input :covering_area
      f.input :product_id, :as => :select, :collection => Product.all.map {|u| [u.title, u.id]}, :include_blank => false
      f.input :user_id, :as => :select, :collection => User.all.map {|u| [u.email, u.id]}, :include_blank => false

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
    
        
    f.has_many :questions do |q|
      if !q.object.id.nil?
        q.input :_destroy, :as => :boolean, :label => "delete"
      end
      q.inputs "Question", :multipart => true do
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
             
    f.buttons
  end    

  show do |event|
    attributes_table do
      row :id
      I18n.available_locales.each do |locale|
        h3 I18n.t(locale, scope: ["translation"])
        div do
          h4 event.translations.where(locale: locale).first.title
        end
      end      
    end
    
    
    div :class => "panel" do
      h3 "Questions"
      if event.questions and event.questions.count > 0
        div :class => "panel_contents" do
          div :class => "attributes_table" do
            table do
              tr do
                th do
                  "Questions"
                end
              end
              tbody do
                
                event.questions.each do |question|
                  div :class => "panel_contents" do
                    div :class => "attributes_table" do
                      table do
                        tr do
                          th do

                            I18n.available_locales.each do |locale|
                              h3 I18n.t(locale, scope: ["translation"])
                              div do
                                h4 question.translations.where(locale: locale).first.title
                              end
                            end 
                          end
                        end
                        tbody do

                          question.answers.each do |answer|
                            tr do
                              td do

                                I18n.available_locales.each do |locale|
                                  h3 I18n.t(locale, scope: ["translation"])
                                  div do
                                    h4 answer.translations.where(locale: locale).first.answer_text
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
          end
        end
      else
        h3 "No comments available"
      end
      
      div :class => "panel" do
        h3 "Participants Completed"
        if event.tickets and event.tickets.count > 0
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
                  event.tickets.each do |ticket|
                    div :class => "panel_contents" do
                      div :class => "attributes_table" do
                        table do
                          tr do
                            th do
                              ticket.cart.user_id
                            end
                            th do
                              ticket.cart.purchased_at
                            end
                            th do
                              ticket.picked_number
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
          h3 "No ticket available"
        end

      end

    end
  end



end

