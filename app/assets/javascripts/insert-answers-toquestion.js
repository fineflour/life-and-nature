jQuery ->
  $buttons = $(".outside-submit")

  for button in $buttons
    $button = $(button)
    $form = $("##{$button.data().formid}")
    $button.on 'click', -> $form.submit()
