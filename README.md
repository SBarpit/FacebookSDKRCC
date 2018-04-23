# FACEBOOK Login :-

> For Facebook login you have to use class FacebookController. 

Firstly register your app with [Facebook](https://developers.facebook.com/apps/) then follow the following steps

## Steps :- 

#### Add followig code to your AppDelegate didFinishLaunchingWithOptions function :-

``` swift
FBSDKApplicationDelegate.sharedInstance().application(application, didFinishLaunchingWithOptions: launchOptions)
```

#### Add following function to your AppDelegate :-

``` swift 
func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {

    return FBSDKApplicationDelegate.sharedInstance().application(application,
                                                                open: url as URL!,
                                                                sourceApplication: sourceApplication,
                                                                annotation: annotation)

}
```

#### Now add following properties to your info.plist :-

``` swift 
<key>CFBundleURLTypes</key>
<array>
<dict>
<key>CFBundleURLSchemes</key>
<array>
<string>fb<FACEBOOK_ID></string> //Replace <FACEBOOK_ID> with your facebook app id 
</array>
</dict>
</array>
<key>FacebookAppID</key>
<string>FACEBOOK_ID</string> //Replace FACEBOOK_ID  with your facebook app id
<key>FacebookDisplayName</key>
<string>APP_DISPLAY_NAME</string> //Replace APP_DISPLAY_NAME  with your facebook app name as on facebook app dashboard
```

#### Now use functions of shared instance of FacebookController :-

- To login and get token from facebook use loginWithFacebook function

``` swift
FacebookController.shared.loginWithFacebook(fromViewController: self) { (result, error) in

    if error == nil ,let result = result {
        let token = result.token
    }
}
```

- To login with share permission use loginWithSharePermission function

``` swift
FacebookController.shared.loginWithSharePermission(fromViewController: self) { (result, error) in

    if error == nil ,let result = result {
        let token = result.token
    }
}
```

- To get user info use getFacebookUserInfo function

``` swift
FacebookController.shared.getFacebookUserInfo(fromViewController: self, success: { (result) in

    self.nameLabel.text = result.name
    self.emailLabel.text = result.email
    print("Your profile Image Url is... \(String(describing: result.picture!))")

}){ (error) in
        print(error?.localizedDescription ?? "")
}

```

Note:- `If you are already logged in then this function will fetch the info of logged in user otherwise it will open login page and then fetch the information`

- To get profile pic only use function getProfilePicFromFacebook

``` swift
FacebookController.shared.getProfilePicFromFacebook(userId: YOUR_USER_ID) { (image) in

    if image = image{
        imageView.image = image
    }
}
```

- To share image with caption use shareImageWithCaptionOnFacebook function

``` swift
FacebookController.shared.shareImageWithCaptionOnFacebook(withViewController: self, IMAGE_URL, CAPTION_TEXT, success: { (result) in

    if let id = result["id"]{

    }

}, failure: { (error) in


})

```

- To share message or text use shareMessageOnFacebook function

``` swift
FacebookController.shared.shareMessageOnFacebook(withViewController: self, MESSAGE, success: { (result) in

    if let id = result["id"]{

    }

}, failure: { (error) in


})
```

- To share message or text use shareVideoWithCaptionOnFacebook function

``` swift
FacebookController.shared.shareVideoWithCaptionOnFacebook(withViewController: self, VIDEO_URL, CAPTION_TEXT, success: { (result) in

    if let id = result["id"]{

    }

}, failure: { (error) in


})

```

- To fetch friends using your app use fetchFacebookFriendsUsingThisAPP function

- To logout use facebookLogout
