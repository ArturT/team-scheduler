jQuery ->
  # tooltip for boards/index.html.erb 
  $("span[rel=tooltip]").tooltip()

  $("span.pie").peity("pie", {
    colours: () ->
      return ["#dddddd", this.getAttribute("data-colour")]
    ,
    diameter: () ->
      return this.getAttribute("data-diameter")
  })