//
//  LoginViewController1.swift
//  Parse_chat
//
//  Created by Tu Pham on 10/4/18.
//  Copyright © 2018 Van Lao. All rights reserved.
//

import UIKit
import Parse

class LoginViewController1: UIViewController {

    @IBOutlet weak var ID_field: UITextField!
    @IBOutlet weak var Password_field: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func onLogin(_ sender: AnyObject) {
        let username = ID_field.text ?? ""  //initialize ID text field as empty.
        let password = Password_field.text ?? ""
        
        PFUser.logInWithUsername(inBackground: username, password: password) { (user: PFUser?, error: Error?) in
            if let error = error {
                print("User log in failed: \(error.localizedDescription)")
            } else {
                print("User logged in successfully")
                self.performSegue(withIdentifier: "loginSegue", sender: nil)
                // display view controller that needs to shown after successful login
            }
        }
    }
    
    @IBAction func onRegister(_ sender: AnyObject) {
        let newUser = PFUser()
        //create an alert tab.
        let alertController = UIAlertController(title: "ERROR", message: "Please fill in Id or password field.", preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default) { (action) in
            // handle response here.
            print("OK button tapped")
        }
        // add the OK action to the alert controller
        alertController.addAction(OKAction)
        
        // set user properties
        newUser.username = ID_field.text
        //newUser.email = emailField.text
        newUser.password = Password_field.text
        
        // call sign up function on the object
        newUser.signUpInBackground { (success: Bool, error: Error?) in
            if let error = error {
                print(error.localizedDescription)
            }
            else if (newUser.username!.isEmpty) || (newUser.password!.isEmpty){
                
                self.present(alertController, animated: true) {
                    // optional code for what happens after the alert controller has finished presenting
                }
            }
            else{
                print("User Registered successfully")
                // manually segue to logged in view
            }
        }
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
