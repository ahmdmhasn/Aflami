//
//  State.swift
//  Aflami
//
//  Created by Ahmed M. Hassan on 12/9/19.
//  Copyright © 2019 ITI. All rights reserved.
//

import Foundation

enum State {
    case loading
    case error(message: String)
    case empty
    case populated
}
