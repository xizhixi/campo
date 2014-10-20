campo.VisibleTo =
  # data-visible-to="options"
  #
  # options:
  #   - user: Visible to logined user
  #     Check if campo.currentUser exists.
  #
  #   - creator: Visible to creator
  #     Find closest element witch has data-creator-id,
  #     and compare with campo.currentUser.id.
  #
  #   - no-creator: Visible to anyone except creator
  #
  #   - topic-creator: visible to topic creator
  #   
  #   - done: visible to who has done
  check: ->
    $('[data-visible-to]').each ->
      $element = $(this)
      rules = $element.data('visible-to').split(/\s/)

      if 'user' in rules
        if !campo.currentUser?
          return $element.remove()

      if 'creator' in rules
        creator_id = $element.closest('[data-creator-id]').data('creator-id')
        if (!campo.currentUser?) or (campo.currentUser.id != creator_id)
          return $element.remove()

      if 'no-creator' in rules
        creator_id = $element.closest('[data-creator-id]').data('creator-id')
        if campo.currentUser? and (campo.currentUser.id == creator_id)
          return $element.remove()

      if 'topic-creator' in rules
        # topic_creator_id = $element.closest('#comments').prev().find('[data-creator-id]').data('creator-id')
        topic_creator_id = $('[data-creator-id]').first().data('creator-id')
        creator_id = $element.closest('[data-creator-id]').data('creator-id')
        info = $element.closest('.clearfix').prev().find('p').text()
        if (!campo.currentUser?) or !((campo.currentUser.id == topic_creator_id) and (info == 'accept!') or (campo.currentUser.id == creator_id))
          return $element.remove()

      if 'done' in rules
        topic_creator_id = $('[data-creator-id]').first().data('creator-id')
        authorized = false
        $('.count').each ->
          done_id = $(this).closest('[data-creator-id]').data('creator-id')
          done_num = $(this).text()
          if campo.currentUser? and ((campo.currentUser.id == topic_creator_id) or (campo.currentUser.id == done_id) and (done_num == '1'))
            authorized = true
            return false
        if !authorized
          return $element.remove()

$(document).on 'page:update', ->
  campo.VisibleTo.check()
