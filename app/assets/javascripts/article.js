$(document).on("turbolinks:load", function() {
  $('#sidebar').width($('#main').width() / 9 * 3)
  $("#sidebar").css("visibility", "visible");
  $('#article_tags').tagsInput();
  content = $('#blog-content').data('content');
  if (content) $('#blog-content').append(marked(content));
  $('pre code').each(function(i, block) {
    hljs.highlightBlock(block);
  });
  $('table').addClass('table table-striped');
  $('.articleImg').zoomify();
})