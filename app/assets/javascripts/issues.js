// $("span#bounty-prompt").click(function(){
//   alert("please sign in with Github to post a bounty");
// });

// $("td#vote-prompt").click(function(){
//   alert("please sign in with Github to vote");
// });

// $("#bounty").click(function(){
//   alert("please sign in with Github to post a bounty");
// });

$('div#refresh').click(function(){
  location.reload();
});

// $('div#endorse').click(function(){
//   $(this).removeAttr('style');
// });

 if ('<%= repo_owner %>'){
    $('div#endorse').removeAttr('style');
    }

//grab the numeric values of two fields
//compare and make sure they are the same
//submit form or return error

  // var first=$('#bounty_price').val(); 
  // var second=$('#bounty').val();

  var first=$('button#pledge').live(
    "click", (function() {
    // alert('this was clicked');
    $('#bounty_price_page').val();
    // console.log(this);
  }));
  
  // console.log(second;)
  console.log(first);

//   var first=document.getElementById('first').value;
// var second=document.getElementById('second').value; 
 
// if(parseInt(first)&lt;parseInt(second))
// alert('Second Value is Greater than first');
 
// else if(parseInt(first)&gt;parseInt(second))
// alert('First Value is Greater than second');
 
// else if(parseInt(first)==parseInt(second))
// alert('First Value and second value is equal');