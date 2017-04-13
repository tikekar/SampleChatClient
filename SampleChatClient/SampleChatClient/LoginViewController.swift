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

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onLogInClick(_ sender: Any) {
    }

   
    @IBAction func onSignupClick(_ sender: Any) {
        
        let user = PFUser()
        user.username = "myname"
        user.password = "mypass"
        user.email = "email@example.com"
        
        user.signUpInBackground { (success : Bool, error: Error?) in
            if error != nil {
                print(error?.localizedDescription ?? "fdfds")
            }
        }
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
