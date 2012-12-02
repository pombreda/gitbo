// $("span#bounty-prompt").click(function(){
//   alert("please sign in with Github to post a bounty");
// });

// $("td#vote-prompt").click(function(){
//   alert("please sign in with Github to vote");
// });

// $("#bounty").click(function(){
//   alert("please sign in with Github to post a bounty");
// });

// $('div#refresh').click(function(){
//   location.reload();
// });

// $('div#endorse').click(function(){
//   $(this).removeAttr('style');
// });

// if ('<%= repo_owner %>'){
//    $('div#endorse').removeAttr('style');
//    }

$('#upvote_issue').click(function(){
  $('#upvote_issue').removeClass().addClass('btn btn-warning');
  $('#downvote_issue').removeClass().addClass('btn');

});
     
$('#downvote_issue').click(function(){
  $('#downvote_issue').removeClass().addClass('btn btn-warning');
  $('#upvote_issue').removeClass().addClass('btn');
});

//grab the numeric values of two fields
//compare and make sure they are the same
//submit form or return error
//need to prevent default for button if wrong
//need to post a notice if wrong
//goes through if match

  $('button#pledge').live(
    "click", (function() {
    pageValue = $('#bounty_price_page').val();
    modalValue(pageValue);
  }));
  
  function modalValue(pageValue) {
    $('#create-bounty').live(
    "click", (function(event) {
    modal = $('#bounty_price').val();
    
    if(parseInt(modal)!=parseInt(pageValue)){
      event.preventDefault();
      $('span#error').replaceWith('<span class="label label-important">Please Enter The Same Value</span>');
    }
    
  }));
}

$('#nevermind').click(function(){
  location.reload();
});


  var url_string = window.location.href.split('?');
  console.log(url_string); 
  if (url_string[1] == "bounty=true") {
    
  }








