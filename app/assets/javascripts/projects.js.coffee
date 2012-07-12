jQuery ->
  # Enabling miniColors
  $(".color-picker").miniColors({
    letterCase: 'uppercase',
    change: (hex, rgb) ->
      #logData('change', hex, rgb);
    ,
    open: (hex, rgb) ->
      #logData('open', hex, rgb);
    ,
    close: (hex, rgb) ->
      #logData('close', hex, rgb);
  })
  
  $("#randomize").click(() -> 
    #alert(1)
    $(".color-picker").miniColors('value', '#' + Math.floor(Math.random() * 16777215).toString(16))
  )