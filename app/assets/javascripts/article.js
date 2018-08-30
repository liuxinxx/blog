$(document).on("turbolinks:load", function() {
  $('#article_tags').tagsInput();
  content = $('#blog-content').data('content');
  if (content) $('#blog-content').append(marked(content));
  $('pre code').each(function(i, block) {
    hljs.highlightBlock(block);
  });
  $('table').addClass('table table-striped');
  $('.articleImg').zoomify();


  var blog = $('.content')
  var i;
  for (i = 0; i < blog.size(); i++) {
    var content = $('#' + blog[i].id).data('content')
    $('#' + blog[i].id).append(marked(content + '...'));
  }
})