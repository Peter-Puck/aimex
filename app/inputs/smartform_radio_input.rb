# File: app/inputs/smartform_radio_input.rb
class SmartformRadioInput < SimpleForm::Inputs::CollectionRadioButtonsInput

  # Creates a radio button set for use with Semantic UI

  def input(wrapper_options = nil)
    label_method, value_method = detect_collection_methods
    iopts = { 
      :item_wrapper_tag => 'label',
      :item_wrapper_class => 'radio',
      :collection_wrapper_tag => 'div',
      :collection_wrapper_class => 'inline-group'
     }
    return @builder.send(
      "collection_radio_buttons",
      attribute_name,
      collection,
      value_method,
      label_method,
      iopts,
      input_html_options,
      &collection_block_for_nested_boolean_style
    )
  end # method

  protected

  def build_nested_boolean_style_item_tag(collection_builder)
    tag = String.new
    # tag << '<div class="ui radio checkbox">'.html_safe
    tag << collection_builder.radio_button + "<i></i>".html_safe + collection_builder.text
    # tag << '</div>'.html_safe
    return tag.html_safe
  end # method

end # class