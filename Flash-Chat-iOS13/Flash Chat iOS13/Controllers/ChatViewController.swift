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
        Message.init(sender: "12@3.com", body: "Hello type new message"),
    

    ]
    
    let db = Firestore.firestore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        
        tableView.register(UINib(nibName: K.cellNibName, bundle: nil), forCellReuseIdentifier: K.cellIdentifier)
        
        
        title = K.appName
        navigationItem.hidesBackButton = true
loadMessages()
        
    }
    
    
    
 

    
    
    func loadMessages() {

    
        db.collection(K.FStore.collectionName).order(by: K.FStore.dateField).addSnapshotListener { querySnapshot, error in
            self.messagesArray = []

            
            if let e = error {
                print("error retrive messages \(e)")
            }else{
                
                if let SnapshotDocuments = querySnapshot?.documents{
                    for doc in SnapshotDocuments {
                        let data = doc.data()
                        if let messageSender = data[K.FStore.senderField] as? String , let messageBody = data[K.FStore.bodyField] as? String {
                            let newMessage = Message.init(sender: messageSender, body: messageBody)
                            
                            self.messagesArray.append(newMessage)
                            
                            DispatchQueue.main.async {
                                self.tableView.reloadData()
                            }
                        }
                    }
                }
                    
                
                
                
                
            }
        }
        
        
        
    }
    
    @IBAction func sendPressed(_ sender: UIButton) {
        
        
        
        if  let messageBody = messageTextfield.text,let messageSender = Auth.auth().currentUser?.email {
            
            db.collection(K.FStore.collectionName).addDocument(data: [
                K.FStore.senderField : messageSender,
                K.FStore.bodyField: messageBody ,
                K.FStore.dateField: Date().timeIntervalSince1970
            ]) { error in
                if let e = error {
                    print("data base error \(e)")
                } else {
                    print("saved successfully")
                    
                }
            }
        }
        
        
    }
    
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




