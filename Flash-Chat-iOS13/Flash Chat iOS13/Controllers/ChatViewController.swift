//
//  ChatViewController.swift
//  Flash Chat iOS13
//
//  Created by Abdullah on 16/02/2022.
//

import Firebase
import UIKit


class ChatViewController: UIViewController {
    @IBOutlet var tableView: UITableView!
    @IBOutlet var messageTextfield: UITextField!
    
    
    var messagesArray: [Message] = [
        Message.init(sender: "12@3.com", body: "Hello3Hello3Hello3Hello3Hello3Hello3Hello3Hello3Hello3Hello3Hello3"),
        Message.init(sender: "123@4.com", body: "Hello4"),
        Message.init(sender: "1234@5.com", body: "Hello5"),
        Message.init(sender: "12345@6.com", body: "Hello6")

    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        
        tableView.register(UINib(nibName: K.cellNibName, bundle: nil), forCellReuseIdentifier: K.cellIdentifier)
        
        
        title = K.appName
        navigationItem.hidesBackButton = true
    }
    
    @IBAction func sendPressed(_ sender: UIButton) {}
    
    @IBAction func logOutPressed(_ sender: UIBarButtonItem) {
        do {
            try Auth.auth().signOut()
            navigationController?.popToRootViewController(animated: true)
        
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
        }
    }
}



extension ChatViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messagesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.cellIdentifier, for: indexPath) as! MessageCell
        cell.label?.text = messagesArray[indexPath.row].body
        return cell
    }
    
    
}

