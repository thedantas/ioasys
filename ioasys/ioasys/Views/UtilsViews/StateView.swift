//
//  StateView.swift
//  ioasys
//
//  Created by Andre Costa Dantas on 17/01/20.
//  Copyright © 2020 Andre Costa Dantas. All rights reserved.
//

import Foundation
import UIKit

//MARK: Protocol
protocol StateSubview {
    func show()
    func hide()
}

//MARK: Enum
enum ViewSelect {
    case loading
    case start
    case empty
    case error(Error)
    case none
}

class StateView: UIView {
    
    //MARK: Variables
    let testTitle = UILabel()
    
    private var didSetupViews: Bool = false
    
    let loadingView = LoadingView()
    let emptyView = NotFindView()
    let startView = StartView()
    let errorView = ErrorView()
    
    var allViews: [StateSubview] {
        return [loadingView, emptyView, startView, errorView]
    }
    
    var state: ViewSelect = .none {
        didSet {
            updateState(state)
        }
    }
    
    //MARK: Functions
    override func layoutSubviews() {
        super.layoutSubviews()
        self.setupViews()
    }
    
    func updateState(_ state: ViewSelect) {
        allViews.forEach { $0.hide() }
        switch state {
        case .loading:
            loadingView.show()
        case .start:
            startView.show()
        case .empty:
            emptyView.show()
        case .error(let error):
            errorView.errorMessage = error.localizedDescription
            errorView.show()
        case .none:
            break
        }
    }
    
    private func setupViews() {
        if !didSetupViews {
            self.didSetupViews = true
            self.setupConstraints()
            self.testTitle.font = UIFont.systemFont(ofSize: 40)
        }
    }
    
    private func setupConstraints() {
        self.addSubview(testTitle)
        self.testTitle.prepareForConstraints()
        self.testTitle.pinBottom(50)
        self.testTitle.centerHorizontally()
        
        self.addSubview(self.loadingView)
        self.loadingView.prepareForConstraints()
        self.loadingView.pinEdgesToSuperview()
        
        self.addSubview(self.emptyView)
        self.emptyView.prepareForConstraints()
        self.emptyView.pinEdgesToSuperview()
        
        self.addSubview(self.startView)
        self.startView.prepareForConstraints()
        self.startView.pinEdgesToSuperview()
        
        self.addSubview(self.errorView)
        self.errorView.prepareForConstraints()
        self.errorView.pinEdgesToSuperview()
    }
}
