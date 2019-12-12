//
//  MoviesListRouter.swift
//  Aflami
//
//  Created by Ahmed M. Hassan on 12/12/19.
//  Copyright © 2019 ITI. All rights reserved.
//

import UIKit

class MoviesListRouter {
    
    private class var storyboard: UIStoryboard {
        return UIStoryboard(name: "Main", bundle: Bundle.main)
    }
    
    public class func createView() -> UIViewController {
        return storyboard.instantiateViewController(withIdentifier: "\(MoviesListVC.self)") as! MoviesListVC
    }
    
}
