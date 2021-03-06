# app/inputs/smartform_datepicker_input.rb 
class SmartformDatetimepickerInput < SimpleForm::Inputs::StringInput
  def input(wrapper_options = nil)
	template.content_tag(:div, div_content, class: "input-group") 
  end

  def div_content
    @builder.text_field(attribute_name, input_html_options) +  template.content_tag(:span, template.content_tag(:i, "", class: "fa fa-calendar"), class: "input-group-addon")
  end


  def input_html_options
    value = object.send(attribute_name)
    options = {
	  readonly: false,
	  ignoreReadonly: true,  
      class: 'form-control datetimepicker'
	  
      #data: { dateformat: 'YYYY/MM/DD HH:mm' }  # for example
    }
    # add all html option you need...
    super.merge options
  end
end


