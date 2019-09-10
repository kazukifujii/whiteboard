App.room = App.cable.subscriptions.create "RoomChannel",

  connected: () ->

  disconnected: () ->

  received: (data) ->
    # alert data['message']
    # console.log data
    message = $(data['message'])
    message.css('background', '#f00')
    $('#messages_index').append(message)

  speak: (message) ->
    @perform 'speak', message: message

  # returnキーでデータを受け取る処理
  $(document).on 'keypress', '[data-behavior~=room_speak]', (event) ->
    if event.keyCode is 13
      # コンソールで接続確認で使ったコード
      App.room.speak event.target.value
      event.target.value = ''
      event.preventDefault()

  $ ->
    $('.message').draggable().dblclick ->
      $(this).wrapInner('<textarea></textarea>').find('textarea').focus().select().blur ->
        $(this).parent().html $(this).val()
