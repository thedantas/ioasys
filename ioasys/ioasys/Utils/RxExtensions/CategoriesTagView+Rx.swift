//
//  CategoriesTagView+Rx.swift
//  ioasys
//
//  Created by Andre Costa Dantas on 17/01/20.
//  Copyright © 2020 Andre Costa Dantas. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

extension Reactive where Base: CategoriesTagView {
    
    var enterprises: Binder<[String]> {
        return Binder(self.base) { categoriesView, enterprise in
            categoriesView.items = enterprise
        }
    }
    
    var tagSelected: Driver<String> {
        return base.collectionView.rx.modelSelected(String.self)
                .asDriver(onErrorJustReturn: "")
    }
    
}
