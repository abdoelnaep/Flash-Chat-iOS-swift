//
//  WelcomeViewController.swift
//  Flash Chat iOS13
//
//  Created by Angela Yu on 21/10/2019.
//  Copyright © 2019 Angela Yu. All rights reserved.
//

import UIKit
class WelcomeViewController: UIViewController {

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
