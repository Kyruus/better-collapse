$ = jQuery

class Accordion
  constructor: (@element, @settings) ->
    @element = $ @element
    @open_element = @element.find @settings.open_target
    @closed_element = @element.find @settings.closed_target

    if @is_open()
      @show()
    else
      @hide()


  show: ->
    @open_element.show()
    @closed_element.hide()

  hide: ->
    @closed_element.show()
    @open_element.hide()

  is_open: ->
    return true  if @element.find(".accordion-body.collapse.in").filter(":visible").length > 0
    false




$.fn.extend
  accordion: (options) ->
    # Default settings
    settings =
      open_target: '.js-open_target'
      closed_target: '.js-closed_target'

    if options and typeof options == 'object'
      settings = $.extend settings, options



    # _Insert magic here._
    return @each () ->
      $this = $ @
      data = $this.data("accordion")
      unless data
        data = $this.data("accordion", new Accordion(@, $this.data()))
      
      if options and typeof options == 'string'
        data[options]()

$(document).on("show.accordion.data-api hide.accordion.data-api", "[data-toggle=accordion]", (e) ->
  $(this).accordion e.type
).ready ->
  $("[data-toggle=accordion]").accordion()     