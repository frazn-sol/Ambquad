class @InfoBoxBuilder extends Gmaps.Google.Builders.Marker # inherit from base builder
  # override method
  create_infowindow: ->
    return null unless _.isString @args.infowindow

    boxText = document.createElement("div")
    boxText.setAttribute("class", 'yellow') #to customize
    boxText.innerHTML = @args.infowindow
    @infowindow = new InfoBox(@infobox(boxText))

  create_infowindow_on_click: ->
    @addListener 'click', @infowindow_binding

  infobox: (boxText) ->
    content: boxText
    disableAutoPan: false
    maxWidth: 0
    pixelOffset: new google.maps.Size(-140, 0)
    zIndex: null
    boxStyle:
      background: "url('http://google-maps-utility-library-v3.googlecode.com/svn/tags/infobox/1.1.5/examples/tipbox.gif') no-repeat"
      opacity: 1
      width: "280px"
    closeBoxMargin: "15px 15px 15px 15px"
    closeBoxURL: "http://www.google.com/intl/en_us/mapfiles/close.gif"
    infoBoxClearance: new google.maps.Size(1, 1)
    isHidden: false
    pane: "floatPane"
    enableEventPropagation: false
    contextmenu: true
  
  $('.yellow').click ->
    alert "Infobox title was clicked!"
