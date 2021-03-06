$(function() {

  $('#new_review').on('submit', function(e) {
    e.preventDefault();
    $.ajax({
      method:$(this).attr('method'),
      url: $(this).attr('action'),
      data: $(this).serialize(),
      dataType: 'json'
    }).done(function(data) {
      // $('.comment_box span').val(' ');
      if(data.errors.length !== 0){
        var error = $('<span class = comment_error>').appendTo('.comment_box');
        $(error).html('<p>' + data.errors[0]+'</p>').css('color','red').css('line-height','3rem')
        .css('font-size', '16.5px');
      }else{
        $('.comment_error').html(' ');
      var review = data['review'],
        comment = $('<li>').prependTo('.reviews').css('margin-left','10%'),
        commenter = $('<li>').prependTo('.reviews').css('margin-left','10%'),
        rate = $('<li>').prependTo( '.reviews').css('margin-left','4%'),
        newDate = new Date(),
        date = formatDate(newDate);
        $(comment).html('<p>' + review.comment + '</p>');
        $(commenter).html('<p> By '+ '<span class = review_maker>' + data.reviewer + '</span>' + ' on ' + date);
        $('.review_maker').css('color', '#337ab7');
        for(i = 0;  i <data.review.rating; i++){
          var star =  $('<span class = glyphicon>');
          $(star).addClass('glyphicon-star');
          $(star).addClass('single_star');
          $(star).appendTo(rate);
          $(' ').appendTo(rate);
        }
        if(data.review_count === 1){
          $('.review_report a').html(data.review_count.toString() + ' review');
        }else{
          $('.review_report a').html(data.review_count.toString() + ' reviews').css('color', '#337ab7');
        }
        $('#review_comment').val(' ');

        // $('.modal').fadeIn();
        // $('button.close').on('click', function(){
        //     $('.modal').fadeOut('slow');
        //     window.location.reload(true);
        // });
      }
      console.log('submit was successful');

    }).fail(function(data) {
      console.log('submit failed');

    }).always(function() {
       $('input[type="submit"]').removeAttr('disabled');

    }).error(function()   {

    });
  });



  function formatDate(date) {
  var monthNames = [
    "January", "February", "March",
    "April", "May", "June", "July",
    "August", "September", "October",
    "November", "December"
  ];

  var day = date.getDate();
  var monthIndex = date.getMonth();
  var year = date.getFullYear();

  return  monthNames[monthIndex] + ' ' + day + ', ' + year;
}
});
