ActiveAdmin.register Event do
  filter :enable, :as => :select

  index do 
    column :id
    column :title
    column("Date Start", :sortable => :date_start) { |task| task.date_start? ? l(task.date_start, :format => :simple) : '-' }    
    column("Date Due", :sortable => :date_due) { |task| task.date_due? ? l(task.date_due, :format => :simple) : '-' }
    column :category, :sortable => :category_id
    column :quiz, :sortable => :quiz_id
    default_actions
  end
  
  form :html => { :enctype => "multipart/form-data" }  do |f|
    f.inputs "Events", :multipart => true do
      f.input :avatar, :as => :file, :multipart => true, :label => "Avatar", :hint => f.object.avatar.nil? ? f.template.content_tag(:span, "No Image Yet") : f.template.image_tag(f.object.avatar.url(:thumb)) 
      f.input :avatar_delete, :as=>:boolean, :required => false, :label => 'Remove image' 
      f.input :category_id, :as => :select, :collection => Category.all.map {|u| [u.title, u.id]}, :include_blank => false
      f.input :quiz_id, :as => :select, :collection => Quiz.all.map {|u| [u.title, u.id]}, :include_blank => false
      f.globalize_inputs :translations do |lf|
        lf.inputs do
          lf.input :title
          lf.input :headline
          lf.input :prize
          lf.input :description, :as => :text
          lf.input :instruction, :as => :text

          lf.input :locale, :as => :hidden
        end
      end
      f.input :enable
      f.input :join_type
      f.input :site_position
      f.input :date_start
      f.input :date_due
      f.input :price_ticket

      f.input :join_min
      f.input :join_max
      f.input :covering_area
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
      if event.quiz.questions and event.quiz.questions.count > 0
        div :class => "panel_contents" do
          div :class => "attributes_table" do
            table do
              tr do
                th do
                  "Questions"
                end
              end
              tbody do
                
                event.quiz.questions.each do |question|
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

