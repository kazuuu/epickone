ActiveAdmin.register Draw do
  form do |f|
    f.inputs "Draws", :multipart => true do
      f.input :avatar
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
         q.inputs :title

         q.has_many :answers do |a|
              if !a.object.id.nil?
                a.input :_destroy, :as => :boolean, :label => "delete"
              end
              a.inputs :title
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

