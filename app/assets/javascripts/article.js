$(document).on("turbolinks:load", function() {
  $('#article_tags').tagsInput();
  content = $('#blog-content').data('content');
  if (content) $('#blog-content').append(marked(content));
  $('pre code').each(function(i, block) {
    hljs.highlightBlock(block);
  });
  $('table').addClass('table table-striped');
  $('.articleImg').zoomify();
})