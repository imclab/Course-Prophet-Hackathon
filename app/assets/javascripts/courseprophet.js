

function selectCourse(name){
  $('#' + courseName).show().attr('checked',true);
}

function submit(){
  $.post('/api/generatePlan',selectedCourses.values(),loadResults(data));
}

function loadResults(data){
  var contents = "";
  for(var i = 0; i < data.length; i++){
    var header = toDate(i),+ ' - ' + sumUnits(data[i]) + ' units.');
    var content = "";
    for (var j = 0; j < data[j].length; j++){
      content += '<tr>' + data[i][j].name + ' - ' + data[i][j].units + ' units' +
                 '<br />'+ data[i][j].description;
    }
    contents += header + content;
  }
  $('#plan').html('<table>' + contents + '</table>');
}

function toDate(i){
  var season;
  switch (i%3){
  case 0: 
    season = "Spring";
    break;
  case 1:
    season = "Winter";
    break
  case 2:
    season = "Fall"
    break;
  }
  var year = 2012 + parseInt((i+1)/3);
  return season + ' ' + year;
}

function viewAll(){
  $('.course').show();
}