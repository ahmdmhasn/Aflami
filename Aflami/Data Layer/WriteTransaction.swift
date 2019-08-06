//
//  WrtieTransaction.swift
//  Aflami
//
//  Created by Ahmed M. Hassan on 8/6/19.
//  Copyright © 2019 ITI. All rights reserved.
//

import Foundation
import RealmSwift

public final class WriteTransaction {
    
    private let realm: Realm
    
    internal init(realm: Realm) {
        self.realm = realm
    }
    
    public func add<T: Object>(_ value: T, update: Bool) {
        realm.add(value, update: update)
    }
    
    public func delete<T: Object>(_ value: T) {
        realm.delete(value)
    }
}
    
