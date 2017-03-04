window.fbAsyncInit = function() {
    FB.init({
        appId      : '719174448253674',
        xfbml      : true,
        version    : 'v2.8'
    });
    FB.AppEvents.logPageView();

    FB.getLoginStatus(function(response) {
        console.log(response.status);
        if (response.authResponse) {
            FB.api('/me', function(response) {
                console.log("Good to see you again, " + response.name + ".");
            });
        }
    });
};


(function(d, s, id){
    var js, fjs = d.getElementsByTagName(s)[0];
    if (d.getElementById(id)) {return;}
    js = d.createElement(s); js.id = id;
    js.src = "//connect.facebook.net/en_US/sdk.js";
    fjs.parentNode.insertBefore(js, fjs);
}(document, 'script', 'facebook-jssdk'));

login = function() {
    FB.login(function(response) {
        if (response.authResponse) {
            console.log('Welcome! Sending hello message...');
            FB.api('/me/feed', 'post', {message: "Hello, world!"}, function(response) {
                console.log(response);
            });
        } else {
            console.log('User cancelled login or did not fully authorize.');
        }
    }, {scope: 'user_posts,publish_actions'});
}