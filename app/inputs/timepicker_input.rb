class TimepickerInput < SimpleForm::Inputs::StringInput
 def input(wrapper_options = nil)
    value = object.send(attribute_name) if object.respond_to? attribute_name

    input_html_options[:type] = 'text'
	#input_html_options[:readonly] = 'false'
    picker_pattern = I18n.t('timepicker.pformat', :default => 'hh:mm')
    input_html_options[:data] ||= { 'show-meridian' => 'false', 'minute-step' => '15'}
    input_html_options[:data].merge!({ format: picker_pattern, language: I18n.locale.to_s,
                                       date_weekstart: I18n.t('datepicker.weekstart', :default => 0) })

    template.content_tag :div, class: 'input-group date timepicker' do

      input = @builder.input_field(attribute_name, input_html_options)
      input += template.content_tag :span, class: 'input-group-addon' do
        template.content_tag :span, '', class: 'glyphicon glyphicon-time', data: { 'time-icon' => 'glyphicon-time', 'date-icon' => 'glyphicon-calendar' }
      end

      input
    end
  end
end