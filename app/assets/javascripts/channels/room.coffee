App.room = App.cable.subscriptions.create "RoomChannel",

  connected: () ->

  disconnected: () ->

  received: (data) ->
    # alert data['message']
    message = $(data['message'])
    message.addClass('.note')
    $('#messages_index').append(message)

  speak: (message) ->
    @perform 'speak', message: message

  delete: (message) ->
    @perform 'delete', message: message

  # returnでデータ受け取る処理
  $(document).on 'keypress', '[data-behavior~=room_speak]', (event) ->
    if event.keyCode is 13
      # speak呼び出してtext内の値を渡す
      App.room.speak event.target.value
      event.target.value = ''
      event.preventDefault()

  # 削除クリックで付箋を消す処理
  $ ->
    $('#del-btn').click ->
      App.room.delete $('.btn').val();
      event.preventDefault()

  # ドラッグ可能にする処理
  # ダブルクリックで編集可能
  $ ->
    $('.note').draggable()
  #  $('.message').draggable().dblclick ->
  #    $(this).wrapInner('<textarea></textarea>').find('textarea').focus().select().blur ->
  #      $(this).parent().html $(this).val()

  $ ->
    $('.note').children('.color-button').click ->
      main_color = $(this).data('main-color')
      sub_color = $(this).data('sub-color')
      shadow_color = $(this).data('shadow-color')
      shadow = $(this).data('shadow')
      $(this).parents('.note').css 'background', "linear-gradient(to right, #{shadow} 0%, #{shadow_color} 0.5%, #{sub_color} 13%, #{main_color} 16%)"
