//
//  LoginViewController.swift
//  Flash Chat iOS13
//
//  Created by Abdullah on 16/02/2022.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    

    @IBAction func loginPressed(_ sender: UIButton) {
        
        
        if let email = emailTextfield.text,let password = passwordTextfield.text {
            
            
            
            Auth.auth().signIn(withEmail: email, password: password) {  authResult, error in
                        
                
                if let e = error{
                    print(e.localizedDescription)
//                    self.errorMessage.text = String(e.localizedDescription)
//                    self.errorMessage.sizeToFit()
                }
                else{
                    self.performSegue(withIdentifier: K.loginSegue, sender: self)
                    
                }
            }
            
        }
        
        
    }
    
}
