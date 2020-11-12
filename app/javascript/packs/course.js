$(document).ready(function() {
  let flag = true;
  $('#sub-field').click();
  $('.nested-fields').first().addClass('hide')
  flag = false

  $('#myTab a').on('click', function(e) {
    e.preventDefault()
    $(this).tab('show')
  });

  $('#sub-field').on('click', function () {
    if(flag) return;
    let inputs = $('.nested-fields:last input')
    let new_row_table = '<tr class="new-record"><td>'+inputs[0].value+
        '</td><td>'+inputs[1].value+
        '</td><td>'+inputs[2].value+
        '</td></tr>'
    $('#body-table').prepend(new_row_table)
    $('.nested-fields').last().addClass('hide')
  });
})
