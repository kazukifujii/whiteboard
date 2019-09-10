App.room = App.cable.subscriptions.create "RoomChannel",

  connected: () ->

  disconnected: () ->

  received: (data) ->
    message = $(data['message'])
    message.addClass('.note')
    $('#messages_index').append(message)
  #  削除ボタン押してからリロードすると消えるので、room_channel.rb の delete までは見に行っている
  #  このアクションが received: (data) で取れない。speakの場合しかreceivedしない原因が不明
  #  データを受け取るのはreceivedしかないのか。
  #  speak を全部speekとかにして動かないなら、デフォルトで決まっていて一意でしか取れなさそう
  #  message = "message-" + $(data['message'])
  #  $(message).remove();

  speak: (message) ->
    @perform 'speak', message: message

  delete: (message) ->
    @perform 'delete', message: message

  # 送信クリック - 付箋作成
  $(document).on 'click', '[data-behavior~=room_speak]', (event) ->
    App.room.speak $('.text').val();
    $('.text').val('');
    event.preventDefault()

  # 削除クリック - 付箋削除
  $(document).on 'click', '[data-behavior~=room_delete]', (event) ->
    App.room.delete $('.del-btn').val();
    event.preventDefault()

  # 付箋ホールド - ドラッグ
  $ ->
    $('.note').draggable()

  # 付箋ダブルクリック - 編集
  $ ->
    $('.note').dblclick ->
      $(this).wrapInner('<textarea class="text" name="text" cols="23" rows="9"></textarea>').find('textarea').focus().select().blur ->
        $(this).parent().html $(this).val()

  # 付箋色変更
  $ ->
    $('.note').children('.color-button').click ->
      main_color = $(this).data('main-color')
      sub_color = $(this).data('sub-color')
      shadow_color = $(this).data('shadow-color')
      shadow = $(this).data('shadow')
      $(this).parents('.note').css 'background', "linear-gradient(to right, #{shadow} 0%, #{shadow_color} 0.5%, #{sub_color} 13%, #{main_color} 16%)"
