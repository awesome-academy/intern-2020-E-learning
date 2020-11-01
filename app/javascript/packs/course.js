$(document).ready(function () {
  let flag = true;

  $('.nested-fields').addClass('hide')
  $('#sub-field').click();

  flag = false

  $('#myTab a').on('click', function (e) {
    e.preventDefault()
    $(this).tab('show')
  });

  $('#sub-field').on('click', function () {
    if(flag) return;
    let inputs = $('.nested-fields:last input')
    let new_row_table = '<tr class="new-record"><td>'+inputs[0].value+
        '</td><td>'+inputs[1].value+
        '</td><td>'+inputs[2].value+
        '</td><td>'+'<button '+
        'id="delete_new_lecture_btn'+ inputs[4].id+
        '" class="btn btn-danger delete_new_lecture">'+
        '<i class="fas fa-trash"></i>'+
        '</button>'+
        '</td></tr>'
    $('#body-table').prepend(new_row_table)
    $('.nested-fields').last().addClass('hide')

    $('#body-table button').on('click', function (){
      let id = this.id.slice(22)
      this.parentElement.parentElement.className += ' hide'
      $('#'+id).prop('checked', true)
    })
  });

  $('.delete_exist_lecture_btn').on('click', function (){
    let id = "course_course_lecture_attributes_"+this.id+"__destroy"
    this.parentElement.parentElement.className += ' hide'
    a = $('#'+id)
    console.log(id)
    $('#'+id).prop('checked', true)
  });
})
