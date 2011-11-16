function toggle_button(off_callback, on_callback) {
  $('.slider-button').toggle(
    function() {
      // off
      $(this).removeClass('on').html($(this).data('off'));
      off_callback();
    },function() {
      // on
      $(this).addClass('on').html($(this).data('on'));
      on_callback();
    }
  );
}