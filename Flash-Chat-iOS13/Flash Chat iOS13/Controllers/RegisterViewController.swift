//
//  RegisterViewController.swift
//  Flash Chat iOS13
//
//  Created by Abdullah on 16/02/2022.
//

import UIKit
import Firebase
class RegisterViewController: UIViewController {

    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    
    @IBOutlet weak var errorMessage: UILabel!
    @IBAction func registerPressed(_ sender: UIButton) {
        
        if let email = emailTextfield.text,let password = passwordTextfield.text {
            
            Auth.auth().createUser(withEmail: email, password: password) { [self] authResult, error in
                
                if let e = error{
                   // print(e.localizedDescription)
                    self.errorMessage.text = String(e.localizedDescription)
                    self.errorMessage.sizeToFit()
                }
                else{
                    self.performSegue(withIdentifier: K.registerSegue, sender: self)
                    
                }
            }
            
        }
        
    
    }
    
}
