document.addEventListener('DOMContentLoaded', function() {

  var sidenav = document.querySelectorAll('.sidenav');
  var sidenav_instances = M.Sidenav.init(sidenav);

  var post_modal = document.querySelectorAll('.modal');
  var postmodal_instances = M.Modal.init(post_modal);

  var today = new Date
  var datepicker = document.querySelectorAll('.datepicker');
  var datepicker_instances = M.Datepicker.init(datepicker,
    {
      autoClose: true,
      format: "yyyy-mm-dd",
      minDate: today,
      container: document.querySelector('#calender'),
      i18n: {
        cancel: 'キャンセル',
        done: '決定',
        months:["1月", "2月", "3月", "4月", "5月", "6月", "7月", "8月", "9月", "10月", "11月", "12月"],
        monthsShort:["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12"],
        weekdays:['日曜日','月曜日','火曜日','水曜日','木曜日','金曜日','土曜日'],
        weekdaysShort:['日','月','火','水','木','金','土'],
        weekdaysAbbrev:['日','月','火','水','木','金','土']
      }
    });

    var select = document.querySelectorAll('select');
    var select_instances = M.FormSelect.init(select);

    var character_counter_text = document.querySelector('#input_name');
    M.CharacterCounter.init(character_counter_text);

    var character_counter_textarea = document.querySelector('#area_description');
    M.CharacterCounter.init(character_counter_textarea);
  });
