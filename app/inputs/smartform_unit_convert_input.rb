# app/inputs/smartform_unit_convert_input.rb 
class SmartformUnitConvertInput < SimpleForm::Inputs::StringInput
include ActionView::Helpers::UrlHelper
  def input(wrapper_options = nil)
	template.content_tag(:div, div_content, class: "input-group") 
  end

  def div_content
    @builder.text_field(attribute_name, input_html_options) + calc_tag 
  end

  def calc_tag
	template.content_tag(:span,   link_to(template.content_tag(:i, "", class: "fa fa-calculator"), "#units_modal", html_options = {'data-toggle' => "modal"}), class: "input-group-addon", :title =>  t(:unit_convert, scope: "simple_form.labels.incident_activity"), :rel => 'tooltip')
  end



  def input_html_options
    value = object.send(attribute_name)
    options = {
	  readonly: false,
	  ignoreReadonly: true,  
      class: 'form-control unit-value'
    }
    # add all html option you need...
    super.merge options
  end
end
