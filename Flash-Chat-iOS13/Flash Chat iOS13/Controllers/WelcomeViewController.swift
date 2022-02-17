//
//  WelcomeViewController.swift
//  Flash Chat iOS13
//
//  Created by Abdullah on 16/02/2022.
//

import UIKit
class WelcomeViewController: UIViewController {
// just comment
    // another comment 
    @IBOutlet weak var titleLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
  
        
        // another way below to do the same thing that cocoapods do
        titleLabel.text = ""
        var charindex = 0.0
        let titleText = K.appName

        for letters in titleText {

            Timer.scheduledTimer(withTimeInterval: 0.1 * charindex, repeats: false) { (Timer) in
                self.titleLabel.text?.append(letters)
            }
            charindex += 1
        }

       
    }
    

}
