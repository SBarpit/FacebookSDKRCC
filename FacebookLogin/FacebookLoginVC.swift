//
//  ViewController.swift
//  FacebookLogin
//
//  Created by Mohammad Umar Khan on 10/08/17.
//  Copyright © 2017 Appinventiv. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit

class FacebookLoginVC: UIViewController{
    
    var fbUserData: [String : AnyObject]!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    
    //MARK: View LifeCycle
    //MARK: ================
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //MARK:- IBAction...
    //MARK: ============
    @IBAction func loginActionButton(_ sender: UIButton) {
        
        FacebookController.shared.getFacebookUserInfo(fromViewController: self, success: { (result) in
            
            self.nameLabel.text = result.name
            self.emailLabel.text = result.email
            print("Your profile Image Url is... \(String(describing: result.picture!))")
            
            
        }) { (error) in
            print(error?.localizedDescription ?? "")
        }
    }
    
    @IBAction func shareTextButtonTapped(_ sender: UIButton) {
        
        let alert = UIAlertController(title: "Share", message: "Enter text to share", preferredStyle: .alert)
        
        alert.addTextField { (textField) in
            
            textField.placeholder = "What's on your mind"
        }
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Done", style: .default, handler: { (action) in
            
            if let text = alert.textFields?[0].text,!text.isEmpty {
                FacebookController.shared.shareMessageOnFacebook(withViewController: self, text, success: { (result) in

                    if let id = result["id"]{
                        self.showAlert(withError: "Shared successfully with post id : \(id) ")
                    }
                    
                }, failure: { (error) in
                    
                    
                })
                alert.dismiss(animated: true, completion: nil)
            }
            
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func shareImageButtonTapped(_ sender: UIButton) {
        
        let alert = UIAlertController(title: "Share", message: "Enter image url and caption to share", preferredStyle: .alert)
        
        alert.addTextField { (textField) in
            
            textField.placeholder = "Image URL"
        }
        
        alert.addTextField { (textField) in
            
            textField.placeholder = "What's on your mind"
        }
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Done", style: .default, handler: { (action) in
            
            if let imageUrl = alert.textFields?[0].text,!imageUrl.isEmpty,let text = alert.textFields?[1].text,!text.isEmpty {
                
                FacebookController.shared.shareImageWithCaptionOnFacebook(withViewController: self,
                                                                          imageUrl,
                                                                          text,
                                                                          success: { (result) in
                                                                            
                                                                            if let id = result["id"]{
                                                                                self.showAlert(withError: "Shared successfully with post id : \(id) ")
                                                                            }
                                                                            
                }, failure: { (error) in
                })
                alert.dismiss(animated: true, completion: nil)
            }
            
        }))
        
        self.present(alert, animated: true, completion: nil)
    }

}

extension UIViewController {
    
    
    func showAlert(withError error : String,_ completion : (()->())? = nil) {
        
        let alertViewController = UIAlertController(title: "", message: error, preferredStyle: UIAlertControllerStyle.alert)
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) { (action : UIAlertAction) -> Void in
            
            alertViewController.dismiss(animated: true, completion: nil)
            completion?()
        }
        
        alertViewController.addAction(okAction)
        
        self.present(alertViewController, animated: true, completion: nil)
        
    }
}
