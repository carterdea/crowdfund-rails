$(function () {
  $('#family_user_cost').mask('000,000,000,000,000', {reverse: true});

  $('.family-details .description').collapser({
    mode: 'words',
    truncate: 50,
    effect: 'slide',
    speed: 'fast',
    showText: 'Read more',
    hideText: 'Read less',
  });

  $('.donor blockquote').collapser({
    mode: 'words',
    truncate: 25,
    effect: 'slide',
    speed: 'fast',
    showText: 'Read more',
    hideText: 'Read less',
  });
});