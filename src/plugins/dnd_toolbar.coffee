#     Hallo - a rich text editing jQuery UI widget
#     (c) 2011 Henri Bergius, IKS Consortium
#     Hallo may be freely distributed under the MIT license
((jQuery) ->
  jQuery.widget 'IKS.dnd_toolbar',

    populateToolbar: (toolbar) ->
      toolbar.prepend '<span class="drag_handle"><i class="icon-reorder"></i></span>'
      toolbar.draggable()

) jQuery
