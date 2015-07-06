# Rivets.Util
# -----------

if window['jQuery'] or window['$']
  [bindMethod, unbindMethod] = if 'on' of $.prototype then ['on', 'off'] else ['bind', 'unbind']

  Rivets.Util =
    bindEvent: (el, event, handler) -> $(el)[bindMethod] event, handler
    unbindEvent: (el, event, handler) -> $(el)[unbindMethod] event, handler
    getInputValue: (el) ->
      $el = $ el

      if $el.attr('type') is 'checkbox' then $el.is ':checked'
      else do $el.val
else
  Rivets.Util =
    bindEvent: do ->
      if 'addEventListener' of window then return (el, event, handler) ->
        el.addEventListener event, handler, false

      (el, event, handler) -> el.attachEvent 'on' + event, handler
    unbindEvent: do ->
      if 'removeEventListener' of window then return (el, event, handler) ->
        el.removeEventListener event, handler, false
      
      (el, event, handler) -> el.detachEvent 'on' + event, handler
    getInputValue: (el) ->
      if el.type is 'checkbox' then el.checked
      else if el.type is 'select-multiple' then o.value for o in el when o.selected
      else el.value
