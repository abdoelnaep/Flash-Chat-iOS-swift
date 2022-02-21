//
//  ChatViewController.swift
//  Flash Chat iOS13
//
//  Created by Abdullah on 16/02/2022.
//

import Firebase
import NaturalLanguage
import UIKit

class ChatViewController: UIViewController {
    @IBOutlet var tableView: UITableView!
    @IBOutlet var messageTextfield: UITextField!

    var messagesArray: [Message] = [
        Message(sender: "12@3.com", body: "Hello type new message"),
    ]

    let db = Firestore.firestore()
    var placeholderwarning = K.textField.placeHolderENGWarn
    var placeholder = K.textField.placeHolderENG

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.register(UINib(nibName: K.cellNibName, bundle: nil), forCellReuseIdentifier: K.cellIdentifier)
        title = K.appName
        navigationItem.hidesBackButton = true
        loadMessages()
        prepareForKeyboardChangeNotification()
    }

    func loadMessages() {
        db.collection(K.FStore.collectionName).order(by: K.FStore.dateField).addSnapshotListener { querySnapshot, error in
            self.messagesArray = []

            if let e = error {
                print("error retrive messages \(e)")
            } else {
                if let SnapshotDocuments = querySnapshot?.documents {
                    for doc in SnapshotDocuments {
                        let data = doc.data()
                        if let messageSender = data[K.FStore.senderField] as? String, let messageBody = data[K.FStore.bodyField] as? String {
                            let newMessage = Message(sender: messageSender, body: messageBody)

                            self.messagesArray.append(newMessage)

                            DispatchQueue.main.async {
                                // self.scrollChatView()

                                let indexPath = IndexPath(row: self.messagesArray.count - 1, section: 0)
                                self.tableView.reloadData()
                                self.tableView.scrollToRow(at: indexPath, at: .top, animated: true) // this line have to be after reload data or getting error
                            }
                        }
                    }
                }
            }
        }
    }

    func prepareForKeyboardChangeNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(changeInputMode), name: UITextInputMode.currentInputModeDidChangeNotification, object: nil)
    }

    @objc
    func changeInputMode(notification: NSNotification) {
        let inputMethod = messageTextfield.textInputMode?.primaryLanguage
        // perform your logic here
        print(inputMethod!)

        if inputMethod == "ar" {
            messageTextfield.placeholder = K.textField.placeHolderAR
            placeholderwarning = K.textField.placeHolderARWarn
            placeholder = K.textField.placeHolderAR

        } else {
            messageTextfield.placeholder = K.textField.placeHolderENG
            placeholderwarning = K.textField.placeHolderENGWarn
            placeholder = K.textField.placeHolderENG
        }
    }

    func scrollChatView() { // another way to scroll table view
        let bottomOffset = CGPoint(x: 0, y: tableView.contentSize.height - tableView.bounds.size.height + 60)
        tableView.setContentOffset(bottomOffset, animated: true)
    }

    @IBAction func sendPressed(_ sender: UIButton) {
        if messageTextfield.text == "" {
            messageTextfield.placeholder = placeholderwarning
        } else {
            if let messageBody = messageTextfield.text, let messageSender = Auth.auth().currentUser?.email {
                db.collection(K.FStore.collectionName).addDocument(data: [
                    K.FStore.senderField: messageSender,
                    K.FStore.bodyField: messageBody,
                    K.FStore.dateField: Date().timeIntervalSince1970,
                ]) { error in
                    if let e = error {
                        print("data base error \(e)")
                    } else {
                        print("saved successfully")
                    }
                }
            }
            messageTextfield.text = ""
            messageTextfield.placeholder = placeholder
            //scrollChatView()
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

extension ChatViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messagesArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let message = messagesArray[indexPath.row]
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: K.cellIdentifier, for: indexPath) as! MessageCell
        cell.label?.text = messagesArray[indexPath.row].body
        
    
        if message.sender == Auth.auth().currentUser?.email {
          cell.leftImageView.isHidden = true
           cell.RightImageView.isHidden = false
           cell.messageBubble.backgroundColor = UIColor(named: K.BrandColors.lightPurple)
           cell.label.textColor = UIColor(named: K.BrandColors.purple)
        }else {
           cell.leftImageView.isHidden = false
           cell.RightImageView.isHidden = true
           cell.messageBubble.backgroundColor = UIColor(named: K.BrandColors.purple)
           cell.label.textColor = UIColor(named: K.BrandColors.lightPurple)
                                 
        }
        
        
        return cell
 
    }
}

