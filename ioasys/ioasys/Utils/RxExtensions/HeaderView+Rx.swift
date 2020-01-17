//
//  HeaderView+Rx.swift
//  ioasys
//
//  Created by Andre Costa Dantas on 17/01/20.
//  Copyright © 2020 Andre Costa Dantas. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

extension Reactive where Base: HeaderView {
    
    var fractionComplete: Binder<CGFloat> {
        return Binder(self.base) { header, fractionComplete in
            header.fractionComplete = fractionComplete
        }
    }
    
    var searchTap: ControlEvent<Void> {
        return self.base.searchButton.rx.tap
    }
    
    var search: Driver<String> {
        return self.base.searchTextField.rx.text
            .asObservable()
            .unwrap()
            .asDriver(onErrorJustReturn: "")
    }
    
}
