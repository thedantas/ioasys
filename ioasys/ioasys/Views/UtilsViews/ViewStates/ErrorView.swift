//
//  ErrorView.swift
//  ioasys
//
//  Created by Andre Costa Dantas on 17/01/20.
//  Copyright © 2020 Andre Costa Dantas. All rights reserved.
//

import Foundation
import UIKit
import Lottie

class ErrorView: UIView, StateSubview {
    
    //MARK: Variables
    private var didSetupViews: Bool = false
    
    var errorMessage: String = "Error!" {
        didSet {
            self.label.text = errorMessage
        }
    }
    
    let label: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.text = "Error!"
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 20)
        return label
    }()
    
    //MARK: Functions
    override func layoutSubviews() {
        super.layoutSubviews()
        self.setupViews()
        self.accessibilityIdentifier = "error_view"
    }
    
    func show() {
        UIView.animate(withDuration: 0.2) {
            self.alpha = 1.0
        }
    }
    
    func hide() {
        UIView.animate(withDuration: 0.2) {
            self.alpha = 0.0
        }
    }
    
    private func setupViews() {
        if !didSetupViews {
            self.didSetupViews = true
            self.setupConstraints()
        }
    }
    
    private func setupConstraints() {
        let imageView = UIImageView(image: #imageLiteral(resourceName: "error"))
        self.addSubview(imageView)
        self.addSubview(label)
        
        imageView.prepareForConstraints()
        imageView.alpha = 0.7
        imageView.constraintWidth(40)
        imageView.constraintHeight(40)
        imageView.centerHorizontally()
        label.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 32.0).isActive = true
        
        label.prepareForConstraints()
        label.pinLeft(32)
        label.pinRight(32)
        label.pinBottom(130)
    }
    
}
