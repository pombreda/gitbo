$('#myTab a.user_tab').click(function (e) {
  e.preventDefault();
  $(this).tab('show');
});

$('.stripe-button').click(function(){
  $('.stripe-button').replaceWith('<span class="label label-inverse">Paid</span>');
});