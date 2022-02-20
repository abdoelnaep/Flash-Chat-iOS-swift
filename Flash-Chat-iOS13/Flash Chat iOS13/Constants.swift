//
//  Constants.swift
//  Flash Chat iOS13
//
//  Created by Abdullah on 16/02/2022.
//

enum K {
    static let appName = "⚡️FlashChat"
    static let cellIdentifier = "ReusableCell"
    static let cellNibName = "MessageCell"
    static let registerSegue = "RegisterToChat"
    static let loginSegue = "LoginToChat"

    enum BrandColors {
        static let purple = "BrandPurple"
        static let lightPurple = "BrandLightPurple"
        static let blue = "BrandBlue"
        static let lighBlue = "BrandLightBlue"
    }

    enum FStore {
        static let collectionName = "messages"
        static let senderField = "sender"
        static let bodyField = "body"
        static let dateField = "date"
    }

    enum textField {
        static let placeHolderAR = "قم بكتابة رسالة"
        static let placeHolderENG = "Write a message"
        static let placeHolderARWarn = "قم بكتابة رسالة ليتم ارسالها"
        static let placeHolderENGWarn = "write message to be sent"
    }
}
