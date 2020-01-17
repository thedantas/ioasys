//
//  UILabel+Rx.swift
//  ioasys
//
//  Created by Andre Costa Dantas on 17/01/20.
//  Copyright © 2020 Andre Costa Dantas. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

extension Reactive where Base: UILabel {
    
    var fontSize: Binder<CGFloat> {
        return Binder(self.base) { label, size in
            let font = label.font.withSize(size)
            label.font = font
        }
    }
    
}


