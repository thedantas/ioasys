//
//  UserDefaultsDataStorageImpl.swift
//  ioasys
//
//  Created by Andre Costa Dantas on 17/01/20.
//  Copyright © 2020 Andre Costa Dantas. All rights reserved.
//

import Foundation
import RxSwift

    //MARK: Struct UserDefaults
    struct LocalStorageKeys {
        private init() {}
        static let pastSearch = "past_search"
        static let firstAccess = "first_access"
    }

class UserDefaultsDataStorageImpl: UserDefaultsDataStorage {
    
    //MARK: Variables
    let userDefaults: UserDefaults

    var lastSearch: Observable<[String]> {
        return userDefaults.rx
            .observe([String].self, LocalStorageKeys.pastSearch)
            .distinctUntilChanged()
            .unwrap()
    }
    
    var firstAccess: Bool {
        get {
            return userDefaults.bool(forKey: LocalStorageKeys.firstAccess)
        } set {
            userDefaults.set(newValue, forKey: LocalStorageKeys.firstAccess)
        }
    }
    
    //MARK: Init
    init(userDefaults: UserDefaults = UserDefaults.standard) {
           self.userDefaults = userDefaults
           userDefaults.register(defaults: [LocalStorageKeys.firstAccess: true])
       }
    
    //MARK: Functions
    func addSearch(_ string: String) {
        let current = userDefaults.array(forKey: LocalStorageKeys.pastSearch) as? [String] ?? []
        let newArray = self.addNewSearch(string.lowercased(), current: current)
        userDefaults.set(newArray, forKey: LocalStorageKeys.pastSearch)
    }
    
    func addNewSearch(_ string: String, current: [String]) -> [String] {
        var newArray = current
        
        if let index = newArray.firstIndex(of: string) {
            newArray.remove(at: index)
        }
        
        if current.count < Constants.savedSearchCount {
            newArray.insert(string, at: 0)
            return newArray
        } else {
    
            newArray.removeLast()
            newArray.insert(string, at: 0)
            return newArray
        }
        
    }
    
}
