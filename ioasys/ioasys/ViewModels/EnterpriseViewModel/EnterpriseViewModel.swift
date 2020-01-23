//
//  EnterpriseViewModel.swift
//  ioasys
//
//  Created by Andre Costa Dantas on 17/01/20.
//  Copyright © 2020 Andre Costa Dantas. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class EnterpriseItemViewModel {
    
    let enterprise: PublishSubject<Enterprise>
    
    let id: Driver<String>
    let description: Driver<String>
    let backgroundImage: Driver<UIImage?>
    let enterprise_name: Driver<String>

    
    init() {
        self.enterprise = PublishSubject<Enterprise>()
        
        self.id = self.enterprise
            .map { $0.id }
            .asDriver(onErrorJustReturn: "")
        
      self.backgroundImage = Driver.just(Random.image)
        
        self.enterprise_name = self.enterprise
        .map { $0.enterprise_name }
                       .asDriver(onErrorJustReturn: "")
        
        self.description = self.enterprise
            .map { $0.description }
            .asDriver(onErrorJustReturn: "")

    }
    
    func bind(_ enterprise: Enterprise) {
        self.enterprise.onNext(enterprise)
        
    }
    
}
