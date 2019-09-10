App.room = App.cable.subscriptions.create "RoomChannel",

  connected: () ->

  disconnected: () ->

  received: (data) ->
    message = $(data['message'])
    message.addClass('.note')
    $('#messages_index').append(message)

  speak: (message) ->
    @perform 'speak', message: message

  delete: (message) ->
    @perform 'delete', message: message

  # 送信をクリックで付箋作成
  $(document).on 'click', '[data-behavior~=room_speak]', (event) ->
    App.room.speak $('.text').val();
    $('.text').val('');
    event.preventDefault()

  # 付箋を消す
  $ ->
    $('#del-btn').click ->
      App.room.delete $('.btn').val();
      event.preventDefault()

  # 付箋をドラッグ
  $ ->
    $('.note').draggable()

  # 付箋をダブルクリックで編集
  $ ->
    $('.note').dblclick ->
      $(this).wrapInner('<textarea class="text" name="text" cols="23" rows="9"></textarea>').find('textarea').focus().select().blur ->
        $(this).parent().html $(this).val()

  # 付箋の色を変える
  $ ->
    $('.note').children('.color-button').click ->
      main_color = $(this).data('main-color')
      sub_color = $(this).data('sub-color')
      shadow_color = $(this).data('shadow-color')
      shadow = $(this).data('shadow')
      $(this).parents('.note').css 'background', "linear-gradient(to right, #{shadow} 0%, #{shadow_color} 0.5%, #{sub_color} 13%, #{main_color} 16%)"
