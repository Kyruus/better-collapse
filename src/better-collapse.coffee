jQuery ->
  class Accordion
    constructor: (element, options) ->
      @$element = $ element
      @$collapse = $ @$element.attr("data-target") or (href = @$element.attr("href")) and href.replace(/.*(?=#[^\s]+$)/, "")
      @settings = $.extend {}, @defaults, options
      @open_element = @$element.find @settings.hideOnCollapsed
      @closed_element = @$element.find @settings.hideOnExpanded

      @render()
    
    render: ->
      if @is_open()
        @show()
      else
        @hide()

    show: ->
      @open_element.removeClass 'hide'
      @closed_element.addClass 'hide'

    hide: ->
      @closed_element.removeClass 'hide'
      @open_element.addClass 'hide'

    is_open: ->
      if @$collapse.parent().find(".collapse.in").filter(":visible").length > 0
        return true
      false

  Accordion::defaults =
    hideOnCollapsed: '[data-hide-on=collapsed]'
    hideOnExpanded: '[data-hide-on=expanded]'

  $.fn.accordion = ( options ) ->
    this.each ->
      $this = $ this
    
      plugin = $this.data 'accordion'

      if plugin is undefined
        settings = $.extend {}, $this.data(), options
        plugin = new Accordion this, settings
        $this.data 'accordion', plugin
      if $.type(options) is 'string'
        plugin[options]()









$(document).on("click.collapse.data-api", "[data-toggle=collapse]", (e) ->
  $this = $ this
  $this.accordion 'render'
).ready ->
  $("[data-toggle=collapse]").accordion()