# app/inputs/smartform_inline_checkbox_input_input.rb 
class SmartformInlineCheckboxInput < SimpleForm::Inputs::Base
  def input(wrapper_options = nil)
    template.content_tag(:label, "#{build_check_box(unchecked_value, wrapper_options)}<i></i>&nbsp;#{label_text}".html_safe, style: "font-weight: normal;" )    
  end

  private

  def build_check_box(unchecked_value, options)
    @builder.check_box(attribute_name, input_html_options, checked_value, unchecked_value)
  end

  def checked_value
    options.fetch(:checked_value, '1')
  end

  def unchecked_value
    options.fetch(:unchecked_value, '0')
  end
end
