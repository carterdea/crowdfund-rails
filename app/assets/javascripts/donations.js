$(function () {
  // When the user clicks the tabs, give the active tab a class of "active"
  $('.page-tabs a[data-toggle="tab"]').on('shown.bs.tab', function (e) {
    $(e.target).addClass('active').siblings().removeClass("active");
  });

  // When the user clicks the "Next" buttons, give the active tab a class of "active"
  $('.btn-primary.btn-block[data-toggle="tab"]').click(function(){
    $('.page-tabs > .active').next('a').trigger('click');
  });

  $('#other_text').mask('000,000,000,000,000', {reverse: true});
  $('#tip_other_text').mask('000,000,000,000,000', {reverse: true});
  // Other Donation amount

  // When the "Other" text field value changes
  $('#other_text').on('click keyup', function(){

    // Check that radio button
    var other_text_value = $('#other_text').val().replace(',','');
    $('#donation_amount_other').prop('checked', true);
    // Change the radio button value to the value in the text field
    $('#donation_amount_other').val(other_text_value);

    // Clean other text values (from $ and ,)
    other_text_value = other_text_value.replace(',','');

    // Calculate Tip
    var tip_10 = (other_text_value * 0.1).toFixed(2);
    var tip_20 = (other_text_value * 0.2).toFixed(2);
    // Change the radio button values to the tip values
    $('#donation_at_tip_10').val(tip_10);
    $('#donation_at_tip_20').val(tip_20);
    // Show Tip
    $('label[for="donation_at_tip_10"] > span').text('$' + tip_10);
    $('label[for="donation_at_tip_20"] > span').text('$' + tip_20);
  });

  // When user clicks a donation amount
  $('label.btn').click(function () {
    setTimeout(function(){ 
      var tip_value = $('label.btn.active > input').val();
      var tip_10 = (tip_value * 0.1).toFixed(2);
      var tip_20 = (tip_value * 0.2).toFixed(2);
      // Change the radio button value to the tip value
      $('#donation_at_tip_10').val(tip_10);
      $('#donation_at_tip_20').val(tip_20);
      // Show Tip
      $('label[for="donation_at_tip_10"] > span').text('$' + tip_10);
      $('label[for="donation_at_tip_20"] > span').text('$' + tip_20);
    }, 100);
    
  });
    

  // When "Other" text field is clicked
  $('#other_text').click(function () {
    // Check the radio button
    $('#donation_amount_other').prop('checked', true);
    $('label.btn').removeClass('active');
  });

  // Other AT Tip amount
  // When the "Other" text field value changes
  $('#tip_other_text').keyup(function () {
    var tip_other_text_value = $('#tip_other_text').val();
    tip_other_text_value = tip_other_text_value.replace(',','');
    // Check that radio button
    $('#donation_at_tip_other').prop('checked', true);
    // Change the radio button value to the value in the text field
    $('#donation_at_tip_other').val(tip_other_text_value);
  });

  $('#tip_other_text').click(function() {
    $('#donation_at_tip_other').prop('checked', true);
  });

  // Format the payment fields
  $('.js-cc-number').payment('formatCardNumber');
  $('.js-cc-expiry').payment('formatCardExpiry');
  $('.js-cc-cvc').payment('formatCardCVC');
});

// Stripe Tokenization
jQuery(function($) {
  $('#new_donation').submit(function(event) {
    var $form = $(this);

    // Disable the submit button to prevent repeated clicks
    $form.find('input[type=submit]').prop('disabled', true);


    // Stripe.card.createToken($form, stripeResponseHandler);
    Stripe.card.createToken({
      number: $('.js-cc-number').val(),
      cvc: $('.js-cc-cvc').val(),
      exp_month: $('.js-cc-expiry').payment('cardExpiryVal').month,
      exp_year: $('.js-cc-expiry').payment('cardExpiryVal').year,
      name: $('#donation_name').val()
    }, stripeResponseHandler);

    // Prevent the form from submitting with the default action
    return false;
  });
});

function stripeResponseHandler(status, response) {
  var $form = $('#new_donation');

  if (response.error) {
    // Show the errors on the form
    $form.find('.payment-errors').text(response.error.message);
    $form.find('input[type=submit]').prop('disabled', false);
  } else {
    // response contains id and card, which contains additional card details
    var token = response.id;
    // Insert the token into the hidden field so it gets submitted to the server
    $form.find($('#donation_stripe_token').val(token));
    // and submit
    $form.get(0).submit();
  }
}

$(function () {
  $('[data-toggle="tooltip"]').tooltip()
})
