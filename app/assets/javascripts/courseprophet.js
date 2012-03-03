function sumUnits(data){
  var sum = 0;
  for (var i = 0; i < data.length; i++){
    sum += data[i].units;
  }
  return sum;
}

function selectCourse(name){
  $('#' + courseName).show().attr('checked',true);
}

function loadResults(data){
  data = data.plan;
  var contents = '<legend>3. Results</legend><div style="text-align: right; margin-bottom: 27px;">'+
  '<div class="btn-group"><a class="btn btn-primary" id="print">Print</a>'+
  '<a class="btn btn-warning" id="startover">Start Over</a></div></div>'
  for(var i = 0; i < data.length; i++){
    var header = 
    '<table class="table table-striped table-bordered"><thead><tr colspan=2><th><h1>' +
    toDate(i)+ ': ' + sumUnits(data[i]) + ' units</h1></th></tr></thead>'
    var content = "<tbody>";
    for (var j = 0; j < data[j].length; j++){
      if (j % 2 == 0){
        content += '<tr>'
      }
      content += '<td><h3>' + data[i][j].name + '</h3><p>'+ data[i][j].description+'</p></td>';
      if ( j % 2 == 1){
        content += '</tr>'
      }
    }
    if (data.length % 2 == 1){
      content += '</tr>';
    }
    content += '</tbody></table>'
    contents += header + content;
  }

  $('#plan').html( contents );
  $('#startover').click(function() {
    $('#step1wrapper').click();
  });
  $('#print').click(function(){
    window.print();
  });
  $('#loader').remove();
  $('#step1wrapper').fadeTo('fast',.25);
  $('#step2wrapper').fadeTo('fast',.4);
  $('#resultswrapper').fadeIn('fast');
  $.scrollTo($('#resultswrapper'),800, {offset: {left: 0, top:-60 }});
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
function clearErrors() {
  $('select').parent().parent().removeClass('error');
  $('input').parent().parent().removeClass('error');
  $('a').removeClass('btn-danger');
  $('.validationerrors').remove();
}
function validateStep1() {
  clearErrors();
  var noerrors = true;
  if($('#major').val() == '') {
    $('#major').parent().parent().addClass('error');
    $('#major').after('<span class="validationerrors help-inline">Select your major.</span>');
    noerrors = false;
  }
  if($('#includeges').is(':checked') && $('#college').val() == '') {
    $('#college').parent().parent().addClass('error');
    $('#college').after('<span class="validationerrors help-inline">Select a college.</span>');
    noerrors = false;
  }
  return noerrors;
}
function validateStep2() {
  clearErrors();
  var noerrors = true;
  if($('#maxunits').val() == '' || isNaN($('#maxunits').val())) {
    $('#maxunits').parent().parent().addClass('error');
    $('#maxunits').after('<span class="validationerrors help-inline">Enter a valid number.</span>');
    noerrors = false;
  } else if($('#maxunits').val() < 12) {
    $('#maxunits').parent().parent().addClass('error');
    $('#maxunits').after('<span class="validationerrors help-inline">There is a 12 unit minimum to be a full time student. Enter a number greater than 12.</span>');
    noerrors = false;
  } else if($('#maxunits').val() > 19.5) {
    $('#maxunits').parent().parent().addClass('error');
    $('#maxunits').after('<span class="validationerrors help-inline">There is a 19.5 unit limit per quarter. Enter a number less than 19.5</span>');
    noerrors = false;
  }
  if(noerrors) {
    $('#step2submit').append( '<img id = "loader" src="assets/ajax-loader-large.gif" />' );
    query = $('#step2').serialize();

    $.ajax({
        type: "POST",
        url: '/api/plan?' + query,
        dataType: 'JSON',
        success: loadResults,
        error: function(){alert(query);noerrors = false;}});
  }
  return noerrors; //remove this once ajax code is in
}
$(document).ready(function() {
  var showclasses = true;
  var step1validated = false;
  var step2validated = false;
  $('#step2').ajaxForm();
  $('#showallclasses').click(function(){
    $('.classes input').each( function() {
      if(!this.checked) {
        if(showclasses) {
          $(this).parent().show();
          $('#showallclasses').text('Hide unselected classes...');
        } else {
          $(this).parent().hide();
          $('#showallclasses').text('Show all classes...');
        }
      }
    });
    showclasses = !showclasses;
  });
  $('.classes input').change(function() {
    if(!this.checked && showclasses) {
      var checkbox = this;
      $(this).parent().mouseout(function() {
        if(!$(this).children('input').is(':checked')) {
          $(this).slideToggle('fast');
        }
        $(this).unbind('mouseout');
      });
    }
  });
  $('#includeges').change(function() {
    $('#collegeselector').slideToggle('fast');
  });
  $('#billoreilly').popover();
  $('#step1wrapper').click(function() {
    if($('#step1wrapper').css("opacity") != 1) {
      $('#step1wrapper').fadeTo('fast',1);
      $('#step2wrapper').fadeTo('fast',.4);
      $('#resultswrapper').fadeOut('fast');
      $.scrollTo($('#step1wrapper'),800, {offset: {left: 0, top:-60 }});
    }
  });

  $('#step2wrapper').click(function() {
    if($('#step2wrapper').css("opacity") != 1 && validateStep1()) {
      $('#step1wrapper').fadeTo('fast',.4);
      $('#step2wrapper').fadeTo('fast',1);
      $('#resultswrapper').fadeOut('fast');
      $.scrollTo($('#step2wrapper'),800, {offset: {left: 0, top:-60 }});
    }
  });
  $('#getstarted').click(function() {
    $('#step1wrapper').fadeIn('fast');
    $('#step2wrapper').fadeTo('fast',.4);
    $.scrollTo($('#step1wrapper'),800, {offset: {left: 0, top:-60 }});
    $(this).unbind('click');
  });
  $('#step1submit').click(function() {
    event.stopPropagation();
    if(validateStep1()) {
      $('#realmajor').val($('#major').val());
      $('#realcollege').val($('#college').val());
      $('#step1wrapper').fadeTo('fast',.4);
      $('#step2wrapper').fadeTo('fast',1);
      $('#resultswrapper').fadeOut('fast');
      $.scrollTo($('#step2wrapper'),800, {offset: {left: 0, top:-60 }});
    }
  });
  $('#step2submit').click(function() {
    event.stopPropagation();
    validateStep2();
  });
  $("#classsearch").keydown(function(e){
   clearErrors();
   var code = (e.keyCode ? e.keyCode : e.which);
   if(code == 13 && !$('ul.typeahead').is(':visible')) {
      $('#addclass').click();
   }
  });
  $('#aboutlink').click(function() {
    $.scrollTo($('.hero-unit'),800, {offset: {left: 0, top:-60 }});
  })
  $('#addclass').click(function() {
    clearErrors();
    var query = $("#classsearch").val();
    var found = false;
    $('.classes').each(function(index) {
      if($(this).children('input').data('course').toLowerCase() == query.toLowerCase()) {
        $(this).slideDown();
        $(this).children('input').attr('checked', true);
        $("#classsearch").val('');
        found = true;
        return false;
      }
    });
    if(!found) {
      $(this).addClass('btn-danger');
      $(this).parent().parent().addClass('error');
      $(this).after('<span class="validationerrors help-inline">Class not found.</span>');
    }
  });
 });