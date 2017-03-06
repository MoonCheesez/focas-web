# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

facebook_button = "#facebook-login"

window.fbAsyncInit = ->
  FB.init({
    appId      : '719174448253674',
    xfbml      : true,
    version    : 'v2.8'
  })

  FB.getLoginStatus((response) ->
    if response.status == "connected"
      display_quote()
    else
      $(facebook_button).show()
  )

PageScript = document.getElementsByTagName("script")[0]
return if document.getElementById("FBScript")
FBScript = document.createElement("script")
FBScript.id = "FBScript"
FBScript.async = true
FBScript.src = "//connect.facebook.net/en_US/all.js"
PageScript.parentNode.insertBefore(FBScript, PageScript)

window.login = ->
  r = (response) ->
    if response.authResponse
      display_quote()

  FB.login(r, {scope: 'user_posts,publish_actions'})

window.display_quote = ->
  $(facebook_button).hide()
  $("#login").fadeOut(1000)
  $("#background").addClass("blur")
  $("#quote").fadeIn(1000)
  start_tracking()

window.out_of_focus = ->
  $("#background").removeClass("blur")
  $("#quote").addClass("blur")

window.in_focus = ->
  $("#background").addClass("blur")
  $("#quote").removeClass("blur")

send_message = (m) ->
  FB.api('/me/feed', 'post', {message: m}, (response) ->
    return response
  )

start_tracking = ->
  eventHandler = (e) ->
    prevType = $(this).data("prevType")

    if prevType != e.type
      switch (e.type)
        when "blur"
          send_message("Slacking off, motivate me to carry on.")
          out_of_focus()
          break
        when "focus"
          send_message("Working hard, do not disturb.")
          in_focus()
          break

    $(this).data("prevType", e.type)

  $(window).on("blur focus", eventHandler)