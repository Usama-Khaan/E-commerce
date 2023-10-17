$(document).ready(function () {
  var csrfToken = $('meta[name="csrf-token"]').attr('content');
  $('.checkout-button').click(function (event) {
    event.preventDefault();
    var quantities = {};
    $('.quantity-input').each(function () {
      var lineItemId = $(this).data('line-item-id');
      var quantity = $(this).val();
      quantities[lineItemId] = quantity;
    });
    $.ajax({
      type: 'PATCH',
      url: '/update_line_items',
      data: { quantities: quantities },
      headers: {
        'X-CSRF-Token': csrfToken
      },
      success: function () {
        window.location.href = '/orders/new';
      }
    });
  });
});
