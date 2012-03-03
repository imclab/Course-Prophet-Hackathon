allCourses = new HashTable();
selectedCourses = new HashTable();
/* <% #Courses.all.each do |course| %>
  allCourses.set(<%=#course.name%>,<%=#course.id%>);
<% #end %> */

function selectCourse(name){
  selectedCourses.put(name,(allCourses.get(name));
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

function appendToList(courseName, checked){
  courseHTML = '<checkbox class = "course" course-name = "' + courseName +
               'checked = ' + checked + ""
               courseName + '</checkbox>';
  $('#classlist').append(courseHTML);
}

function toggleCourse(){
  courseName = $(this).attr('course-name');
  if ($(this).attr('checked')){
    $(this).attr('checked',false);
    selectedCourses.remove(courseName);
  }else{
    $(this).attr('checked',true);
    selectedCourses.put(courseName,allCourses.get(courseName));
  }
}

function viewAll(){
  $('#classlist').empty();
  classes = allClasses.keys();
  for (int i = 0; i < classes.length; i++){
    appendToList(classes[i],selectedCourses.hasKey(classes[i]));
  }
}