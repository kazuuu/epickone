ActiveAdmin.register Question do
  form :html => { :enctype => "multipart/form-data" }  do |q|
    q.inputs "Question", :multipart => true do
      q.input :quiz_id, :as => :select, :collection => Quiz.all.map {|u| [u.title, u.id]}, :include_blank => true
      q.input :avatar, :as => :file, :multipart => true, :label => "Avatar", :hint => q.object.avatar.nil? ? q.template.content_tag(:span, "No Image Yet") : q.template.image_tag(q.object.avatar.url(:thumb)) 
      q.input :avatar_delete, :as=>:boolean, :required => false, :label => 'Remove image' 

      q.globalize_inputs :translations do |qt|
        qt.inputs do
          qt.input :title
          qt.input :description, :as => :text
          qt.input :locale, :as => :hidden
        end
      end      
      q.input :sort_order         
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

            a.input :right_answer
            a.input :sort_order
          end
        end
      end
    end
             
    q.buttons
  end    
end
# 
# div :class => "panel" do
#   h3 "Questions"
#   if event.quiz.questions and event.quiz.questions.count > 0
#     div :class => "panel_contents" do
#       div :class => "attributes_table" do
#         table do
#           tr do
#             th do
#               "Questions"
#             end
#           end
#           tbody do
#             
#             event.quiz.questions.each do |question|
#               div :class => "panel_contents" do
#                 div :class => "attributes_table" do
#                   table do
#                     tr do
#                       th do
# 
#                         I18n.available_locales.each do |locale|
#                           h3 I18n.t(locale, scope: ["translation"])
#                           div do
#                             h4 question.translations.where(locale: locale).first.title
#                           end
#                         end 
#                       end
#                     end
#                     tbody do
# 
#                       question.answers.each do |answer|
#                         tr do
#                           td do
# 
#                             I18n.available_locales.each do |locale|
#                               h3 I18n.t(locale, scope: ["translation"])
#                               div do
#                                 h4 answer.translations.where(locale: locale).first.answer_text
#                               end
#                             end 
#                           end
#                         end
#                       end
#                     end
#                   end
#                 end
#               end
#             end
#           end
#         end
#       end
#     end
#   else
#     h3 "No comments available"
#   end
#   
#   div :class => "panel" do
#     h3 "Participants Completed"
#     if event.tickets and event.tickets.count > 0
#       div :class => "panel_contents" do
#         div :class => "attributes_table" do
#           table do
#             tr do
#               th do
#                 "user_id"
#               end
#               th do
#                 "purchased_at"
#               end
#               th do
#                 "picked_number"
#               end
#             end
#             tbody do
#               event.tickets.each do |ticket|
#                 div :class => "panel_contents" do
#                   div :class => "attributes_table" do
#                     table do
#                       tr do
#                         th do
#                           ticket.cart.user_id
#                         end
#                         th do
#                           ticket.cart.purchased_at
#                         end
#                         th do
#                           ticket.picked_number
#                         end
#                       end
#                     end
#                   end
#                 end
#               end
#             end
#           end
#         end
#       end
#     else
#       h3 "No ticket available"
#     end
#   end
# end
