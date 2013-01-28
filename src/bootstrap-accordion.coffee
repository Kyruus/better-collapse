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
  accordion: (method) ->
    # Default settings
    settings =
      open_target: '.js-open_target'
      closed_target: '.js-closed_target'

    return @each () ->
      $this = $ @
      settings = $.extend settings, $this.data()
      data = $this.data("accordion")
      
      unless data
        data = $this.data("accordion", new Accordion(@, settings))
      
      if method and typeof method == 'string'
        data[method]()

$(document).on("show.accordion.data-api hide.accordion.data-api", "[data-toggle=accordion]", (e) ->
  $(this).accordion e.type
).ready ->
  $("[data-toggle=accordion]").accordion()     