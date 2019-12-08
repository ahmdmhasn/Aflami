//
//  Persistable.swift
//  Aflami
//
//  Created by Ahmed M. Hassan on 8/6/19.
//  Copyright © 2019 ITI. All rights reserved.
//

import Foundation
import RealmSwift

public protocol Persistable {
    
    associatedtype ManagedObject: RealmSwift.Object
    
    init(managedObject: ManagedObject)
    
    func managedObject() -> ManagedObject
    
}
