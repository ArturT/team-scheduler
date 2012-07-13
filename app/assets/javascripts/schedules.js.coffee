jQuery ->
  # #329678 When editing schedules the second calender should update to the month picked in the first one 
  $('#schedule_start_date').change(() ->
    start_date = new Date($('#schedule_start_date').val()).getTime()
    end_date = new Date($('#schedule_end_date').val()).getTime()
    if not $('#schedule_end_date').val()
      $('#schedule_end_date').val($('#schedule_start_date').val())
    else
      if start_date > end_date
        $('#schedule_end_date').val($('#schedule_start_date').val()))

  $('#schedule_end_date').change(() ->
    start_date = new Date($('#schedule_start_date').val()).getTime()
    end_date = new Date($('#schedule_end_date').val()).getTime()
    if not $('#schedule_start_date').val()
      $('#schedule_start_date').val($('#schedule_end_date').val())
    else
      if start_date > end_date
        $('#schedule_start_date').val($('#schedule_end_date').val()))