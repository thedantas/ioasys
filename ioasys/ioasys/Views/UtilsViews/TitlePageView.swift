//
//  TitlePageView.swift
//  ioasys
//
//  Created by Andre Costa Dantas on 17/01/20.
//  Copyright © 2020 Andre Costa Dantas. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class HeaderView: UIView {

    //MARK: Variables
    let maxHeight: CGFloat = 160
    let minHeight: CGFloat = 72
    var heightConstraint: NSLayoutConstraint!
    var search: Driver<String>!
    var fractionComplete: CGFloat = 0.0
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: 30, height: self.maxHeight)
    }
    
    private let logo: UIImageView = {
        let imageView = UIImageView(image: #imageLiteral(resourceName: "norristones_logo"))
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let searchTextField: UITextField = {
       let textField = UITextField()
        textField.backgroundColor = UIColor.white.withAlphaComponent(0.4)
        textField.layer.cornerRadius = 10.0
        textField.textColor = .white
        textField.tintColor = .white
        textField.font = UIFont.boldSystemFont(ofSize: 18)
        textField.clearsOnBeginEditing = true
        textField.accessibilityIdentifier = "search_input"
        return textField
    }()
    
    let searchButton: UIButton = {
        let button = UIButton()
      //  button.setImage(#imageLiteral(resourceName: "search"), for: .normal)
        button.accessibilityIdentifier = "search_button"
        return button
    }()
    
    let blurView: UIVisualEffectView = {
        let view = UIVisualEffectView(effect: UIBlurEffect(style: .light))
        view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        return view
    }()
    
    let bottomLine: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white.withAlphaComponent(0.5)
        return view
    }()
    
    //MARK: Function
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setupViews()
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        self.setupViews()
    }
    //MARK: Setups
    private func setupViews() {
        self.backgroundColor = .clear
        self.setupConstraints()
        self.searchTextField.placeholder = "Research a fact"
        self.setupBindings()
    }
    
    private func setupBindings() {
        let editingDidEnd = self.searchTextField.rx
            .controlEvent(.editingDidEnd)
            .asObservable()
        
        let searchTap = self.searchButton.rx
            .tap
            .asObservable()
        
        self.search = Observable.merge(editingDidEnd, searchTap)
            .withLatestFrom(self.searchTextField.rx.text.asObservable())
            .unwrap()
            .asDriver(onErrorJustReturn: "")
    }
    
    private func setupConstraints() {
        
        self.addSubview(self.blurView)
        self.addSubview(self.searchTextField)
        self.addSubview(self.searchButton)
        self.addSubview(self.bottomLine)
        self.addSubview(self.logo)
        
        self.blurView.prepareForConstraints()
        self.searchTextField.prepareForConstraints()
        self.searchButton.prepareForConstraints()
        self.bottomLine.prepareForConstraints()
        self.logo.prepareForConstraints()
        
        self.blurView.pinEdgesToSuperview()
        
        self.logo.pinLeft(85.0)
        self.logo.pinBottom(50.0)
        self.logo.pinRight(85.0)
        
        self.searchTextField.pinLeft(20.0)
        self.searchTextField.pinRight(20.0)
        self.searchTextField.pinBottom(12.0)
        self.searchTextField.constraintHeight(36.0)
        
        self.searchButton.pinBottom(18.0)
        self.searchButton.pinRight(36.0)
        self.searchButton.constraintHeight(20.0)
        self.searchButton.constraintWidth(20.0)
        
        self.bottomLine.constraintHeight(1)
        self.bottomLine.pinRight()
        self.bottomLine.pinLeft()
        self.bottomLine.pinBottom()
    
        self.heightConstraint = self.constraintHeight(self.maxHeight)
        
        self.layoutIfNeeded()
        
    }
    
}

