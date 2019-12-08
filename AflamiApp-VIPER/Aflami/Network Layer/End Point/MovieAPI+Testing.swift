//
//  MyAPI+Testing.swift
//  Network Layer
//
//  Created by Ahmed M. Hassan on 8/1/19.
//  Copyright © 2019 ITI. All rights reserved.
//

import Foundation

extension MovieAPI {
    
    public var sampleData: Data {
        switch self {
        // Change this ya Hassan and add stubbed responses for the all cases
        case .login: return stubbedResponse("Test")
        default: return stubbedResponse("Test")
        }
    }
    
}

func stubbedResponse(_ fileName: String) -> Data! {
    @objc class TestClass: NSObject { }
    
    let bundle = Bundle(for: TestClass.self)
    let path = bundle.path(forResource: fileName, ofType: "json")
    return (try? Data(contentsOf: URL(fileURLWithPath: path!)))
}
