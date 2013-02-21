jQuery ->
  class BetterCollapse
    constructor: (element, options) ->
      @$element = $ element
      @$collapse = $ options['target'] or (href = @$element.attr("href")) and href.replace(/.*(?=#[^\s]+$)/, "")
      @$parent = $ options['parent']
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
      @$parent.find(@settings.hideOnCollapsed).addClass 'hide'
      @$parent.find(@settings.hideOnExpanded).removeClass 'hide'

      @open_element.removeClass 'hide'
      @closed_element.addClass 'hide'

    hide: ->
      @closed_element.removeClass 'hide'
      @open_element.addClass 'hide'

    is_open: ->
      if @$collapse.parent().find(".collapse.in").filter(":visible").length > 0
        return true
      false

  BetterCollapse::defaults =
    hideOnCollapsed: '[data-hide-on=collapsed]'
    hideOnExpanded: '[data-hide-on=expanded]'

  $.fn.better_collapse = ( options ) ->
    this.each ->
      $this = $ this
    
      plugin = $this.data 'better_collapse'

      if plugin is undefined
        settings = $.extend {}, $this.data(), options
        plugin = new BetterCollapse this, settings
        $this.data 'better_collapse', plugin
      if $.type(options) is 'string'
        plugin[options]()









$(document).on("click.collapse.data-api", "[data-toggle=collapse]", (e) ->
  $this = $ this
  $this.better_collapse 'render'
).ready ->
  $("[data-toggle=collapse]").better_collapse()