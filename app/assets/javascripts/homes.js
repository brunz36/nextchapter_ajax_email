// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.


// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

$(document).ready(function() {


  $('body').on('click', '.home-favorite', function(event) {
    let homeId = $(this).data('home-id')
    let favorited = $(this).hasClass('favorited')

    $(this).toggleClass('favorited')

    console.log(`Handle click: ${homeId}`)

    let url = favorited ? `/homes/${homeId}/unfavorite` : `/homes/${homeId}/favorite`
    $.ajax({
      method: 'POST',
      url: url,
      dataType: 'script'
    })
  })

  $('#query').on('input', _.debounce(function(event) {
    let queryValue = $(this).val()

    $.ajax({
      url: '/homes',
      data: { query: queryValue },
      dataType: 'script'
    })
  }, 400))

  // THERE REALLY SHOULD BE A BETTER WAY WITH TOGGLE!!!
  $('body').on('click', '.sq-feet', function(event){
    let sqFeet = $(this).data("sq_feet")
    let sqMeters = $(this).data("sq-meters")
    let showingMeters = $(this).data('showing-meters')

    if (showingMeters === 'true') {
      $(this).text(`${sqFeet} Square Feet`)
      $(this).data('showing-meters', 'false')
    } else {
      $(this).text(`${sqMeters} Square Meters`)
      $(this).data('showing-meters', 'true')
    }
  })

  // TOO MUCH CODE

  $('.page a').on('click', function(event) {
    let pageNumber = $(this).text()
    event.preventDefault()

    $.ajax({
      url: '/homes',
      data: { page: pageNumber },
      dataType: 'script'
    })
  })
})
