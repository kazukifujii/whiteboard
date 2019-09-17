App.room = App.cable.subscriptions.create "RoomChannel",

  connected: () ->

  disconnected: () ->

  received: (data) ->
    if data['sticky_note'] != undefined
      sticky_note = $(data['sticky_note'])
      sticky_note.attr('id', 'note')
      $('#sticky_notes_index').append(sticky_note)
    else
      $('.sticky_note_' + data['id']).remove()

  speak: (sticky_note) ->
    @perform 'speak', sticky_note: sticky_note

  remove: (sticky_note) ->
    @perform 'remove', sticky_note: sticky_note

  # 送信クリック - 付箋作成
  $(document).on 'click', '[data-behavior~=room_speak]', (e) ->
    App.room.speak $('.text').val();
    $('.text').val('');
    e.preventDefault()

  # 削除クリック - 付箋削除
  $(document).on 'click', '.remove-icon', (e) ->
    if !confirm('本当に削除しますか？')
      return false;
    else
      id = $(e.target).data('sticky_note-id')
      App.room.remove id
      e.preventDefault()

  # 付箋ホールド - ドラッグ
  $ ->
    $('.note').draggable()

  # 付箋ダブルクリック - 編集
  $ ->
    $('.note').dblclick ->
      $(this).wrapInner('<textarea class="text" name="text" cols="23" rows="8"></textarea>').find('textarea').focus().select().blur ->
        $(this).parent().html $(this).val()

  # 付箋の色変更
  $ ->
    $('.note').children('.color-button').click ->
      main_color = $(this).data('main-color')
      sub_color = $(this).data('sub-color')
      shadow_color = $(this).data('shadow-color')
      shadow = $(this).data('shadow')
      $(this).parents('.note').css 'background', "linear-gradient(to right, #{shadow} 0%, #{shadow_color} 0.5%, #{sub_color} 13%, #{main_color} 16%)"
