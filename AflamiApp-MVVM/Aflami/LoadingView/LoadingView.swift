//
//  LoadingView.swift
//  LoadingDemo
//
//  Created by Ahmed M. Hassan on 11/29/19.
//  Copyright © 2019 Ahmed M. Hassan. All rights reserved.
//

import UIKit

class LoadingView: UIView {
    
    // MARK: - Constants
    static var color: UIColor = .gray
    static var userInteractionEnabled: Bool = true
    static var showDarkBackground: Bool = false
    static var message: String = "Loading"
    
    // MARK: - Outlets

    @IBOutlet var parentView: UIView!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var label: UILabel!
    
    static let shared = LoadingView()
    
    // MARK: - Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        commitInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func commitInit() {
        Bundle.main.loadNibNamed("LoadingView", owner: self, options: nil)
        
        activityIndicator.color = LoadingView.color
        parentView.isUserInteractionEnabled = !LoadingView.userInteractionEnabled
        parentView.backgroundColor = LoadingView.showDarkBackground ? UIColor(white: 0, alpha: 0.8) : .clear
        label.text = LoadingView.message
        label.isHidden = LoadingView.message.isEmpty
    }
    
    /**
     Shows loading view attatched to window with user interactions disabled
     */
    static func show(animated: Bool = true) {
        if let window = UIApplication.shared.keyWindow {
            LoadingView.shared.parentView.isUserInteractionEnabled = true
            LoadingView.shared.showAddedTo(window)
        }
    }
    
    /**
     Hide loading view when attatched to UIWindow
     */
    static func hide(animated: Bool = true) {
        if let window = UIApplication.shared.keyWindow {
            LoadingView.shared.hide(fromView: window)
        }
    }

    /**
     Show loading view
     */
    func showAddedTo(_ view: UIView, animated: Bool = true) {
        
        if view.subviews.contains(parentView) { return }
        
        view.addSubview(parentView)
        
        // Add constraints
        addConstraintsForParentView()
        
        // Add animation
        if animated {
            parentView.alpha = 0
            UIView.animate(withDuration: 0.3) {
                self.parentView.alpha = 1
            }
        }
    }
        
    /**
     Hide loading view
     */
    func hide(fromView view: UIView, animated: Bool = true) {
        for v in view.subviews {
            if v == parentView {
                self.remove(v, animated: animated)
            }
        }
    }
    
    // MARK: - Private Handlers
    
    private func addConstraintsForParentView() {
        parentView.translatesAutoresizingMaskIntoConstraints = false
        var constraints = [NSLayoutConstraint]()
        constraints += NSLayoutConstraint.constraints(withVisualFormat: "V:|[parentView]|", options: .alignAllCenterY, metrics: nil, views: ["parentView":parentView!])
        constraints += NSLayoutConstraint.constraints(withVisualFormat: "H:|[parentView]|", options: .alignAllCenterX, metrics: nil, views: ["parentView":parentView!])
        NSLayoutConstraint.activate(constraints)
    }
    
    private func remove(_ view: UIView, animated: Bool) {
        if animated {
            UIView.animate(withDuration: 0.3, animations: {
                view.alpha = 0
            }) { (completed) in
                view.removeFromSuperview()
            }
        } else {
            view.removeFromSuperview()
        }
    }
    
}
