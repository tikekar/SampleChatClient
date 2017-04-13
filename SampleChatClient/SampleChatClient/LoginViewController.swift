//
//  LoginViewController.swift
//  SampleChatClient
//
//  Created by Gauri Tikekar on 4/12/17.
//  Copyright © 2017 Gauri Tikekar. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController {

    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var usernameTextField: UITextField!
    
    let alertController = UIAlertController(title: "Login Failed ", message: "Login/Password Cannot Be Empty", preferredStyle: .alert)
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onLogInClick(_ sender: Any) {
        PFUser.logInWithUsername(inBackground: usernameTextField.text!.lowercased(), password:passwordTextField.text!) {
            (user: PFUser?, error: Error?) -> Void in
            if user != nil {
                self.performSegue(withIdentifier: "Show Chat View", sender: nil)
               
            } else {
                // The login failed. Check error to see why.
                print(error ?? "login error")
                
                // create an OK action
                let OKAction = UIAlertAction(title: "OK", style: .default) { (action) in
                    // handle response here.
                }
                // add the OK action to the alert controller
                self.alertController.addAction(OKAction)
                
                self.present(self.alertController, animated: true) {
                    // optional code for what happens after the alert controller has finished presenting
                }
            }
        }
    }

   
    @IBAction func onSignupClick(_ sender: Any) {
        
        let user = PFUser()
        user.username = "gauri"
        user.password = "gauri"
        user.email = "gauri@example.com"
        
        user.signUpInBackground { (success : Bool, error: Error?) in
            if error != nil {
               // print(error?.localizedDescription ?? "fdfds")
                print(error ?? "signup error")
            }
        }
        
        /*user.signUpInBackgroundWithBlock {
            (succeeded: Bool, error: NSError?) -> Void in
            if let error = error {
                let errorString = error.userInfo["error"] as? NSString
                // Show the errorString somewhere and let the user try again.
            } else {
                // Hooray! Let them use the app now.
            }
        } as! PFBooleanResultBlock as! PFBooleanResultBlock*/
        
    }
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
    }

}
