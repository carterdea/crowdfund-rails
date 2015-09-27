$(function () {

  $('#grant_user_amount_requested').mask('000,000,000,000,000', {reverse: true});

  $('.grant .body').collapser({
    mode: 'words',
    truncate: 100,
    effect: 'slide',
    speed: 'fast',
    showText: 'Read more',
    hideText: 'Read less',  
  });

});