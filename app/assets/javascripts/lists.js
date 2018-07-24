function add_fields(link, association, content) {
  var new_id = new Date().getTime();
  var regexp = new RegExp("new_" + association, "g");
  $(link).before(content.replace(regexp, new_id).repeat(10));
}
$(document).on('turbolinks:load', function() {
  $('#add_fields').click(function() {
    add_fields(this, $(this).attr("data-association"), $(this).attr("data-fields"))
    return false;
  });
});
