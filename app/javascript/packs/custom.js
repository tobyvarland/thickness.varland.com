$(function() { $('[data-toggle="tooltip"]').tooltip(); });
$(function() { $('[data-toggle="popover"]').popover(); });

var LinkValidator = {
  selector: '.shop-order-pdf',
  validateLinks: function() {
    $(LinkValidator.selector).each(function() {
      var link = $(this);
      $.ajax({
        type: 'get',
        url: link.attr("href"),
        error: function() {
          link.remove();
        },
      });
    })
  }
};

$(function() {
  LinkValidator.validateLinks();
  $('.filters-button').on('click', function() {
    var target = $(this).data('target');
    $('html,body').animate({
      scrollTop: $(target).offset().top
    }, 'fast');
  });
});