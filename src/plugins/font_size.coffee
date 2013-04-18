#     Font size widget
#     (c) 2013 Tatemae
((jQuery) ->
  jQuery.widget "IKS.font_size",
    options:
      editable: null
      uuid: ''
      sizes: [8, 10, 12, 14, 16, 18, 24, 30, 36]
      buttonCssClass: null
      label: 'Size'
      is_text_button: true

    populateToolbar: (toolbar) ->
      widget = this
      buttonset = jQuery "<span class=\"#{widget.widgetName}\"></span>"
      contentId = "#{@options.uuid}-#{widget.widgetName}-data"
      target = @_prepareDropdown contentId
      toolbar.append buttonset
      buttonset.hallobuttonset()
      buttonset.append target
      buttonset.append @_prepareButton target

    _prepareDropdown: (contentId) ->
      contentArea = jQuery "<div id=\"#{contentId}\"></div>"

      addSize = (size) =>

        el = jQuery "<button class='font_size'>
          <div class=\"menu-item\">#{size}px</div>
        </button>"

        el.on 'click', =>
          @options.editable.execute 'fontSize', 7
          jQuery("font", @options.editable.element).each (idx, elem) =>
            font = jQuery(elem)

            jQuery(".iks_font_size", font).each (idxx, old_span) =>
              jQuery(old_span).contents().unwrap()

            if font.attr('size') == "7"
              font.replaceWith("<span class=\"iks_font_size\" style=\"font-size:#{size}px;\">#{font.html()}</span>");

        queryState = (event) =>
          block = document.queryCommandValue 'formatBlock'
          # if block.toLowerCase() is element
          #   el.addClass 'selected'
          #   return
          # el.removeClass 'selected'

        events = 'keyup paste change mouseup'
        @options.editable.element.on events, queryState

        @options.editable.element.on 'halloenabled', =>
          @options.editable.element.on events, queryState
        @options.editable.element.on 'hallodisabled', =>
          @options.editable.element.off events, queryState

        el

      for size in @options.sizes
        contentArea.append addSize size
      contentArea


    _prepareButton: (target) ->
      buttonElement = jQuery '<span></span>'
      buttonElement.hallodropdownbutton
        uuid: @options.uuid
        editable: @options.editable
        is_text_button: @options.is_text_button
        icon: ''
        label: @options.label
        target: target
        cssClass: @options.buttonCssClass
      buttonElement

)(jQuery)