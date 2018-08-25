function add_fields(link, association, content) {
  var newId = new Date().getTime();
  var regexp = new RegExp("new_" + association, "g");
  tabindex = parseInt($($('form.simple_form.edit_list input[type!=submit], form.simple_form.new_list input[type!=submit]').last()).attr("tabindex")) + 1;
  $(link).before(content.replace(regexp, newId));
  // Add tabindices to new fields.
  var newLinks = $('form.simple_form.edit_list input[tabindex=replace_me], form.simple_form.new_list input[tabindex=replace_me]');
  for (var i = 0; i < newLinks.length; i++) {
    $(newLinks[i]).attr('tabindex', tabindex++);
    $(newLinks[i]).keydown(nextInputOnEnter);
  }
  // Add keydown events to new links.

}

function nextInputOnEnter(e) {
  if (e.keyCode == 13) {
    e.preventDefault();
    // Jump to the next input based on tabindex.
    var currentTabindex = parseInt($(this).attr('tabindex'));
    var nextInput = $('form.simple_form.edit_list input[type!=submit][tabindex=' + (currentTabindex+1) + '], form.simple_form.new_list input[type!=submit][tabindex=' + (currentTabindex+1) + ']')[0];
    if (typeof nextInput !== 'undefined') {
      nextInput.focus();
    }
  }
}

$(document).on('turbolinks:load', function() {
  $('#add_fields').click(function() {
    add_fields(this, "links", parsed.more_fields.repeat(10));
    return false;
  });
  $('form.simple_form.edit_list input[type!=submit], form.simple_form.new_list input[type!=submit]').keydown(nextInputOnEnter);
});
