# app/inputs/smartform_datepicker_input.rb 
class SmartformDatepickerInput < SimpleForm::Inputs::StringInput
	def input(wrapper_options = nil)
   @builder.text_field(attribute_name, input_html_options) + 
      template.content_tag(:span, template.content_tag(:i, "", class: "fa fa-calendar"), class: "input-group-addon")
  end

  def input_html_options
    value = object.send(attribute_name)
    options = {
	#  readonly: true,
	  ignoreReadonly: true,  
      class: 'form-control datepicker',
	  
      data: { dateformat: 'yy-mm-dd' }  # for example
    }
    # add all html option you need...
    super.merge options
  end
end
