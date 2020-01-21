//
//  LoadingView.swift
//  ioasys
//
//  Created by Andre Costa Dantas on 17/01/20.
//  Copyright © 2020 Andre Costa Dantas. All rights reserved.
//

import Foundation
import UIKit
import Lottie

class LoadingView: UIView, StateSubview {
    
    //MARK: Variable
    private var didSetupViews: Bool = false
    var lottieView: AnimationView?
    let label: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.text = "Loading..."
        label.font = UIFont.boldSystemFont(ofSize: 20)
        return label
    }()
    
    //MARK: Function
    override func layoutSubviews() {
        super.layoutSubviews()
        self.setupViews()
        self.accessibilityIdentifier = "loading_view"
    }
    
    func show() {
        UIView.animate(withDuration: 0.2) {
            self.alpha = 1.0
        }
        lottieView?.play()
    }
    
    func hide() {
        UIView.animate(withDuration: 0.2) {
            self.alpha = 0.0
        }
        lottieView?.stop()
    }
    
    private func setupViews() {
        if !didSetupViews {
            self.didSetupViews = true
            self.setupConstraints()
        }
    }
    
    private func setupConstraints() {
        self.lottieView = AnimationView(name: "searching")
        self.addSubview(lottieView!)
        self.addSubview(label)
        
        lottieView?.alpha = 0.8
        lottieView?.constraintWidth(120.0)
        lottieView?.constraintHeight(120.0)
        lottieView?.prepareForConstraints()
        lottieView?.centerHorizontally()
        lottieView?.centerVertically()
        lottieView?.loopMode = .loop
        
        label.prepareForConstraints()
        label.centerHorizontally()
        label.pinBottom(130)
    }
    
}
