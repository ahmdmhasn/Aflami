//
//  Log.swift
//  Aflami
//
//  Created by Ahmed M. Hassan on 12/12/19.
//  Copyright © 2019 ITI. All rights reserved.
//

import Foundation

public func log(_ items: Any...) {
    #if DEBUG
    print(items)
    #endif
}
