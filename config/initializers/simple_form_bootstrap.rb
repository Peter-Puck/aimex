# Use this setup block to configure all options available in SimpleForm.
SimpleForm.setup do |config|
  config.wrappers :bootstrap, tag: 'div', class: 'control-group', error_class: 'error' do |b|
    b.use :html5
    b.use :placeholder
    b.use :label
    b.wrapper tag: 'div', class: 'controls' do |ba|
      ba.use :input
      ba.use :error, wrap_with: { tag: 'span', class: 'help-inline' }
      ba.use :hint,  wrap_with: { tag: 'p', class: 'help-block' }
    end
  end

  config.wrappers :prepend, tag: 'div', class: "control-group", error_class: 'error' do |b|
    b.use :html5
    b.use :placeholder
    b.use :label
    b.wrapper tag: 'div', class: 'controls' do |input|
      input.wrapper tag: 'div', class: 'input-prepend' do |prepend|
        prepend.use :input
      end
      input.use :hint,  wrap_with: { tag: 'span', class: 'help-block' }
      input.use :error, wrap_with: { tag: 'span', class: 'help-inline' }
    end
  end

  config.wrappers :append, tag: 'section', class: '', error_class: 'invalid' do |b|
    b.use :html5
    b.use :placeholder
    b.use :label
    b.wrapper tag: 'label', class: 'input' do |input|
      input.wrapper tag: 'div', class: 'input-group' do |append|
        append.use :input
      end
      input.use :hint,  wrap_with: { tag: 'span', class: 'help-block' }
      input.use :error, wrap_with: { tag: 'span', class: 'help-inline' }
    end
  end

  config.wrappers :smartform, tag: 'section', class: '', error_class: 'state-error' do |b|
    b.use :html5
    b.use :placeholder
    b.use :label
    b.use :maxlength
    b.wrapper tag: 'label', class: 'input' do |ba|
      ba.use :input
      ba.use :error, wrap_with: { tag: 'em', class: 'invalid' }
      ba.use :hint,  wrap_with: { tag: 'p', class: 'help-block' }
    end
  end

  config.wrappers :smartform_text_area_wrapper, tag: 'section', class: '', error_class: 'state-error' do |b|
    b.use :html5
    b.use :placeholder
    b.use :label
    b.use :maxlength
    b.wrapper tag: 'label', class: 'textarea' do |ba|
      ba.use :input, class: 'custom-scroll'
      ba.use :error, wrap_with: { tag: 'em', class: 'invalid' }
      ba.use :hint,  wrap_with: { tag: 'p', class: 'help-block' }
    end
  end

  config.wrappers :smartform_checkbox_wrapper, tag: 'section', class: '', error_class: 'state-error' do |b|
    b.use :html5
    b.use :label
    b.wrapper tag: 'div', class: 'inline-group' do |ba|
      ba.use :input
      ba.use :error, wrap_with: { tag: 'em', class: 'invalid' }
      ba.use :hint,  wrap_with: { tag: 'p', class: 'help-block' }
    end
  end

  config.wrappers :smartform_inline_checkbox_wrapper, tag: 'section', class: '', error_class: 'state-error' do |b|
    b.use :html5
    b.wrapper tag: 'div', class: 'inline-group remove-margins' do |ba|
      ba.use :input
      ba.use :error, wrap_with: { tag: 'em', class: 'invalid' }
      ba.use :hint,  wrap_with: { tag: 'p', class: 'help-block' }
    end
  end

  config.wrappers :smartform_radio_wrapper, tag: 'section', class: '', error_class: 'state-error' do |b|
    b.use :html5
    b.use :label
    b.use :input
    b.use :error, wrap_with: { tag: 'em', class: 'invalid' }
    b.use :hint,  wrap_with: { tag: 'p', class: 'help-block' }
  end

  config.wrappers :smartform_file_wrapper, tag: 'section', class: '', error_class: 'state-error' do |b|
    b.use :html5
    b.use :label
    b.wrapper tag: 'div', class: 'input input-file' do |ba|
      ba.use :input
      ba.use :error, wrap_with: { tag: 'em', class: 'invalid' }
      ba.use :hint,  wrap_with: { tag: 'p', class: 'help-block' }
    end
  end

  # Wrappers for forms and inputs using the Twitter Bootstrap toolkit.
  # Check the Bootstrap docs (http://twitter.github.com/bootstrap)
  # to learn about the different styles for forms and inputs,
  # buttons and other elements.
  config.default_wrapper = :smartform
end
