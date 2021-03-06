App.room = App.cable.subscriptions.create "RoomChannel",
  connected: ->
    # Called when the subscription is ready for use on the server

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
    # Called when there's incoming data on the websocket for this channel
    console.log(data)
    $('#messages').append data['message']
    area = $('.message-area')
    area.animate({ scrollTop: area.prop('scrollHeight')}, 1000);

  speak: (message) ->
    @perform 'speak', message: message

  login: (email) ->
    @perform 'login', email: email


  $(document).on 'keypress', '[data-behavior~=room_speaker]', (event) ->
    if event.keyCode is 13 # return/enter = send
      App.room.speak event.target.value
      event.target.value = ''
      event.preventDefault()

  $(document).on 'click', '[data-behavior~=quick_reply_btn]', (event) ->
    $('.userip').focus()
    App.room.speak event.target.textContent
