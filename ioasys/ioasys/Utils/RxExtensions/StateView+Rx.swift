//
//  StateView+Rx.swift
//  ioasys
//
//  Created by Andre Costa Dantas on 17/01/20.
//  Copyright © 2020 Andre Costa Dantas. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import UIKit

extension Reactive where Base: StateView {
    
    var state: Binder<ViewSelect> {
        return Binder(self.base) { stateView, state in
            stateView.state = state
        }
    }
    
}
