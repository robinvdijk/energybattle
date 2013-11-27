$(document).ready(function(){
    callFB();
    $(".send_notifications").on("click", function(){
      FB.ui({method: "send", link: "test.com"});
    });
    $(".invite_with_fb").on("click", function(){
      FB.ui({method: "apprequests", message: "Energybattle de nieuwe ultime game"});
    });
});

function callFB(){
    window.fbAsyncInit = function() {
      FB.init({
        appId      : '533003410107372', // App ID
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
}