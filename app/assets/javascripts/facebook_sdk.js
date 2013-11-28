$(document).ready(function(){
    callFB();
    $(".send_notifications").on("click", function(){
      FB.ui({method: "send", to: "100003692456003", name: "Doe je mee met Energy Battle?", link: "www.Energybattle.com"});
    });
    $(".invite_with_fb").on("click", function(){
      FB.ui({method: "apprequests", message: "Energybattle de nieuwe ultime game"});
    });
    $(".post_on_feed").on("click", function(){
      FB.ui({
        method: "feed", 
        link: "www.energybattle.nl", 
        name: "Energy Battle",
        picture: 'http://fbrell.com/f8.jpg',
        description: "Wil je ook een lagere energierekening en een schoner milieu? Doe mee met Energy Battle!", 
        caption: "Ik heb 1000 punten behaald bij Energy Battle!"});
    });
    
});

function callFB(){
    window.fbAsyncInit = function() {
      FB.init({
        appId      : 534518849970647, // App ID
        status     : true,    // check login status
        cookie     : true,    // enable cookies to allow the
                            // server to access the session
        xfbml      : true     // parse page for xfbml or html5
      });

    // Additional initialization code here
  };
}
  // Load the SDK Asynchronously
  (function(d){
     var js, id = 'facebook-jssdk'; if (d.getElementById(id)) {return;}
     js = d.createElement('script'); js.id = id; js.async = true;
     js.src = "//connect.facebook.net/en_US/all.js";
     d.getElementsByTagName('head')[0].appendChild(js);
   }(document));

  var fbAppId = '534518849970647';
  var objectToLike = 'http://techcrunch.com/2013/02/06/facebook-launches-developers-live-video-channel-to-keep-its-developer-ecosystem-up-to-date/';

  // This check is just here to make sure you set your app ID. You don't
  // need to use it in production. 
  if (fbAppId === 'lol') {
    alert('Please set the fbAppId in the sample.');
  }



 function tickerInfo(){
FB.api(
  'https://graphc.facebook.com/me/energybattle:win',
  'post',
  {
    battle: "http://samples.ogp.me/558093757613156"
  },
  function(response) {
    if (!response) {
           alert('Error occurred.');
         } else if (response.error) {
           document.getElementById('result2').innerHTML =
             'Error: ' + response.error.message;
         } else {
           document.getElementById('result2').innerHTML =
             '<a href=\"https://www.facebook.com/me/activity/' +
             response.id + '\">' +
             'Story created.  ID is ' +
             response.id + '</a>';
         }
  }
);
  }
