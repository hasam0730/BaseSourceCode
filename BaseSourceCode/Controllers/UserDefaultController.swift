//
//  UserDefaultController.swift
//  BaseSourceCode
//
//  Created by mac mini on 9/11/18.
//  Copyright © 2018 Developer. All rights reserved.
//

import Foundation

var UserHolder = userData()

struct userData {
    /*we can make so many instance from userdefaults by assigning different suiteNames.
     so each instance can has its own properties without messing things around and
     overriding in their own properties*/
    
    // private let defaultStorage = UserDefaults(suiteName: "com.yourcompany.appname")
    
    private let defaultStorage = UserDefaults.standard
    
    enum UserDefaultsKeys:String {
        case userToken
        case name
        case age
        case avatarLink
    }
    
    //retriving data from Default Storage
    private func getFromdefaultStorage(key: UserDefaultsKeys ) -> String {
        if let response = defaultStorage.value(forKey: key.rawValue )  {
            return response as! String
        } else {
            return ""
        }
    }
    
    // Putting data in Default Storage
    private func saveTodefaultStorage(key:UserDefaultsKeys, val:String) {
        defaultStorage.set(val, forKey: key.rawValue)
    }
    
    //Delete All User Data
    func deleteAllData(){
        let domain = Bundle.main.bundleIdentifier!
        UserDefaults.standard.removePersistentDomain(forName: domain)
        UserDefaults.standard.synchronize()
    }
    
    
    //user Token
    var userToken : String {
        get {
            return getFromdefaultStorage(key: .userToken)
        }
        set(newValue){
            saveTodefaultStorage(key: UserDefaultsKeys.userToken, val: newValue)
        }
    }
    
    //user name
    var name : String {
        get {
            return getFromdefaultStorage(key: .name)
        }
        set(newValue){
            saveTodefaultStorage(key: UserDefaultsKeys.name, val: newValue)
        }
    }
    
    //user age
    var age : String {
        get {
            return getFromdefaultStorage(key: .age)
        }
        set(newValue){
            saveTodefaultStorage(key: UserDefaultsKeys.age, val: newValue)
        }
    }
    
    //user avatar
    var avatarLink : String {
        get {
            return getFromdefaultStorage(key: .avatarLink)
        }
        set(newValue){
            saveTodefaultStorage(key: UserDefaultsKeys.avatarLink, val: newValue)
        }
    }
    
}
