# ############################
# JQuery Plugin Initialization
# ############################

@event_toggle_reveal = () ->
  $('.toggle_reveal').change (event) ->
    reveal = $(this).data("revealfalse") 
    if $(this).is(':checked')
      $("." + reveal).hide("fast")
    else
      $("." + reveal).show("fast")
    reveal = $(this).data("revealtrue") 
    if $(this).is(':checked')
      $("." + reveal).show("fast")
    else
      $("." + reveal).hide("fast")


@load_custom_confirm = () ->

    $.rails.allowAction = (element) ->
      message = element.data('confirm')
      ok_button = element.data('ok')
      cancel_button = element.data('cancel')
      return true unless message
      $link = element.clone()
        .removeAttr('class')
        .removeAttr('data-confirm')
        .addClass('btn').addClass('btn-success')
        .html(ok_button)
      modal_html = """
                                    <div class="modal fade">
                                      <div class="modal-dialog">
                                        <div class="modal-content">
                                          <div class="modal-header">
                                            <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                                            <h4 class="modal-title">Confirm</h4>
                                          </div>
                                          <div class="modal-body">
                                            <p>""" + message + """</p>
                                          </div>
                                          <div class="modal-footer">
                                            <a data-dismiss="modal" class="btn btn-danger">Cancel</a>
                                          </div>
                                        </div>
                                      </div>
                                    </div>  
                   """
      $modal_html = $(modal_html)
     
      $modal_html.find('.modal-footer').append($link)
      $modal_html.modal()
      $link.click (e) ->
        e.preventDefault()
        $(this).closest('.modal').modal('hide')
        element.trigger('ajax:complete')
        # Prevent the original link from working
      return false
      


    
@load_autonumeric = () ->
  $("input[type=text].week_of_Year").autoNumeric( 'init', {vMin: '0', vMax: '52'} )
  $("input[type=text].day_of_month").autoNumeric( 'init', {vMin: '1', vMax: '31'} )
  $("input[type=text].currency").autoNumeric( 'init', {aSign: '$ '} )
  $("input[type=text].percentage").autoNumeric( 'init', {aSign: ' % ', pSign: 's', vMax: '999.99'} )
  $("input[type=text].quantity").autoNumeric( 'init', {vMax: '999999.99', vMin: '0.00'} )
  $("input[type=text].quantity_adjustment").autoNumeric( 'init', {vMax: '999999.99', vMin: '-999999.99'} )

@load_tabs = () ->
  $('#tabs').tabs()
  $('.tabs').tabs()
  $('input.timepicker').timepicker
    showMeridian: false

@load_summernote = () ->
  $(".summernote").summernote
    height: 160
    focus: false
    tabsize: 2
    toolbar: [
      [
        "style"
        [
          "bold"
          "italic"
          "underline"
          "clear"
        ]
      ]
      [
        "fontsize"
        [
          "fontsize"
        ]
      ]
      [
        "color"
        [
          "color"
        ]
      ]
      [
        "layout"
        [
          "ul"
          "ol"
        #  "paragraph"
        ]
      ]
      [
        "misc"
        [
          "fullscreen"
        #  "codeview"
          "undo"
          "redo"
          "help"
        ]
      ]
    ]

@load_summernote_small = () ->
  $(".summernote").summernote
    height: 100
    focus: false
    tabsize: 2
    toolbar: [
      [
        "style"
        [
          "bold"
          "italic"
          "underline"
          "clear"
        ]
      ]
      [
        "color"
        [
          "color"
        ]
      ]
      [
        "fontsize"
        [
          "fontsize"
        ]
      ]
      [
        "layout"
        [
          "ul"
          "ol"
         # "paragraph"
        ]
      ]
      [
        "misc"
        [
          "fullscreen"
        #  "codeview"
          "undo"
          "redo"
          "help"
        ]
      ]
    ]

@load_datatables = () ->
	responsiveHelper_dt_basic = `undefined`
	responsiveHelper_datatable_fixed_column = `undefined`
	responsiveHelper_datatable_col_reorder = `undefined`
	responsiveHelper_datatable_tabletools = `undefined`
	breakpointDefinition =
	  tablet: 1024
	  phone: 480
      

	$("#dt_users").DataTable
	  ajax: "/users.json"
	  columns: [
	    { data: "user_url" } 
        { data: "email" } 
	  ]	  
	  sDom: "<'dt-toolbar'<'col-xs-12 col-sm-6'f><'col-sm-6 col-xs-12 hidden-xs'l>r>" + "t" + "<'dt-toolbar-footer'<'col-sm-6 col-xs-12 hidden-xs'i><'col-xs-12 col-sm-6'p>>"
	  autoWidth: true
	  stateSave: false
	  preDrawCallback: ->
	    # Initialize the responsive datatables helper once.
	    responsiveHelper_dt_basic = new ResponsiveDatatablesHelper($(".dt_basic"), breakpointDefinition)  unless responsiveHelper_dt_basic
	    return
	  rowCallback: (nRow) ->
	    responsiveHelper_dt_basic.createExpandIcon nRow
	    return
	  drawCallback: (oSettings) ->
	    responsiveHelper_dt_basic.respond()
	    return
        

@load_calendars = () ->
  $ ->
		$("#calendar").fullCalendar
		  buttonText:
		    prev: "<i class=\"fa fa-chevron-left\"></i>"
		    next: "<i class=\"fa fa-chevron-right\"></i>"
		  eventRender: (event, element, icon) ->
		    element.find(".fc-event-title").append "<br/><span class='ultra-light'>" + event.description + "</span>"  if not event.description is ""
		    element.find(".fc-event-title").append "<i class='air air-top-right fa " + event.icon + " '></i>"  if not event.icon is ""
		    return
		  windowResize: (event, ui) ->
		    $("#calendar").fullCalendar "render"
		    return
		  dayClick: (date, event, view) ->
	      console.log "dayClick"
	      $(".fc-state-highlight").removeClass("fc-state-highlight")
	      $(event.target).addClass("fc-state-highlight")
	      return

	# hide default buttons 
	$(".fc-header-right, .fc-header-center").hide()
	$("#calendar-buttons #btn-prev").click ->
	  $(".fc-button-prev").click()
	  false

	$("#calendar-buttons #btn-next").click ->
	  $(".fc-button-next").click()
	  false

	$("#calendar-buttons #btn-today").click ->
	  $(".fc-button-today").click()
	  false


@prepare_user_avatar_modal = () ->
  runAllForms()

@prepare_training_photo_modal = () ->
  runAllForms()



# ### Home Model ###

@setup_home_index = () ->
  console.log 'Home'




jQuery ->
  load_tabs()
  load_summernote_small()
  load_datatables()
  load_calendars()
  event_toggle_reveal()
  load_custom_confirm()