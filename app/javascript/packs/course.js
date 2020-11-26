$(document).ready(function () {
  let flag = true;
  $('.nested-fields').addClass('hide')
  $('#sub-field').click();

  let number_pattern = /\d+/;
  let course_lecture_fields = [];
  let course_lecture_inputs = $('.nested-fields:first input');
  Object.values(course_lecture_inputs).forEach(function (elem) {
    if (!elem.id) return;
    let field_name = elem.id.split(number_pattern).pop();
    if (field_name == 'destroy') field_name = '_' + field_name;
    course_lecture_fields.push(field_name);
  });

  flag = false

  $('#myTab a').on('click', function (e) {
    e.preventDefault()
    $(this).tab('show')
  });

  $('#sub-field').on('click', function () {
    if(flag) return;
    let input_id = $('.nested-fields:last input')[0].id;
    let finger_print = input_id.match(number_pattern)[0];

    let new_row_table = '<tr class="new-record" id = "tr'+
                        finger_print +
                        '">';
    course_lecture_fields.forEach(function(elem){
      let col_id = 'course_course_lecture_attributes_' +
                    finger_print + elem;
      if (elem == '__destroy') {
        new_row_table += '<td>' + '<button '+
            'id= "'+ finger_print +
            '" class="btn btn-danger delete_new_lecture">'+
            '<i class="fas fa-trash"></i>'+
            '</button>' + '</td>';
      }
      else new_row_table += '<td>' + $('#'+col_id).val() + '</td>';
    });
    new_row_table += '</tr>';

    $('#body-table').prepend(new_row_table)
    $('.nested-fields').last().addClass('hide')

    $('#body-table button').on('click', function (){
      let finger_print = this.id;
      let checkbox_id = 'course_course_lecture_attributes_' + finger_print + '__destroy';
      $('#tr'+finger_print).addClass('hide');
      $('#'+checkbox_id).prop('checked', true)
    })
  });

  $('.delete_exist_lecture_btn').on('click', function (){
    let id = 'course_course_lecture_attributes_' + this.id + '__destroy'
    this.parentElement.parentElement.className += ' hide'
    $('#'+id).prop('checked', true)
  });
})
