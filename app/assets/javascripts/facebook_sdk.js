$(document).ready(function(){
    callFB();
    $("#send_notifications").on("click", function(){
      FB.ui({method: "send", to: "100003692456003", name: "Doe je mee met Energy Battle?", link: "www.Energybattle.com"});
    });
    $("#invite_with_fb").on("click", function(){
      FB.ui({method: "apprequests", message: "Energybattle de nieuwe ultime game"});
    });
    $("#post_on_feed").on("click", function(){
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
        appId      : '533003410107372', // App ID Energybattle Development
        //appId      : '534518849970647', // App ID Pruts_app Production
      });
    // Additional initialization code here
  };

  // Load the SDK Asynchronously
  (function(d){
     var js, id = 'facebook-jssdk'; if (d.getElementById(id)) {return;}
     js = d.createElement('script'); js.id = id; js.async = true;
     js.src = "//connect.facebook.net/en_US/all.js";
     d.getElementsByTagName('head')[0].appendChild(js);
   }(document));

  var fbAppId = '533003410107372';  // App ID Energybattle Development
  //var fbAppId = '534518849970647'; // App ID Pruts_app Production
  var objectToLike = 'http://techcrunch.com/2013/02/06/facebook-launches-developers-live-video-channel-to-keep-its-developer-ecosystem-up-to-date/';
  };
};