class PhoneNumberNoDddInput < SimpleForm::Inputs::Base
  def input
    "<label id='city_phone_code' style='display:inline;'>(DDD)</label> #{@builder.text_field(attribute_name, input_html_options)}".html_safe
  end
end
