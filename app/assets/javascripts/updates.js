$(function () {

  $('.well .update .body').collapser({
    mode: 'words',
    truncate: 10,
    effect: 'slide',
    speed: 'fast',
    showText: 'Read more',
    hideText: 'Read less',  
  });

  $('.update .body').collapser({
    mode: 'words',
    truncate: 100,
    effect: 'slide',
    speed: 'fast',
    showText: 'Read more',
    hideText: 'Read less',  
  });
});