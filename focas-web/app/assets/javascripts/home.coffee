# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

window.display_quote = ->
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

window.fbAsyncInit = ->
  FB.init({
    appId      : '719174448253674',
    xfbml      : true,
    version    : 'v2.8'
  })

  FB.getLoginStatus((response) ->
    window.login_status = response.status
    button_selector = "#facebook-login"
    if window.login_status == "connected"
      display_quote()
      $(button_selector).hide()
    else
      $(button_selector).show()
  )

PageScript = document.getElementsByTagName("script")[0]
return if document.getElementById("FBScript")
FBScript = document.createElement("script")
FBScript.id = "FBScript"
FBScript.async = true
FBScript.src = "//connect.facebook.net/en_US/all.js"
PageScript.parentNode.insertBefore(FBScript, PageScript)

window.login = ->
  FB.login(((response) ->
    if response.authResponse
      window.login_status = "connected"
      set_button_status(window.login_status)
    else
      console.log('User cancelled login or did not fully authorize.')
    ), {scope: 'user_posts,publish_actions'})

send_message = (m) ->
  FB.api('/me/feed', 'post', {message: m}, (response) ->
    return response
  )

start_tracking = ->
  $(window).on("blur focus", (e) ->
    prevType = $(this).data("prevType")

    if prevType != e.type
      switch (e.type)
        when "blur"
          #send_message("Slacking off, motivate me to carry on.")
          out_of_focus()
          break
        when "focus"
          #send_message("Working hard, do not disturb.")
          in_focus()
          break

    $(this).data("prevType", e.type)
  )