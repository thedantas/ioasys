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
    
    let text: Driver<String>
    let description: Driver<String>
    let backgroundImage: Driver<UIImage?>
    let fontSize: Driver<CGFloat>

    
    init() {
        self.enterprise = PublishSubject<Enterprise>()
        
        self.text = self.enterprise
            .map { $0.enterprise_name }
            .asDriver(onErrorJustReturn: "")
        
      self.backgroundImage = Driver.just(Random.image)
        
        self.fontSize = self.text
            .map {
                return $0.count < 80 ?
                    Constants.largeFontSize : Constants.mediumFontSize
        }
        
        self.description = self.enterprise
            .map { $0.description }
            .asDriver(onErrorJustReturn: "")

    }
    
    func bind(_ enterprise: Enterprise) {
        self.enterprise.onNext(enterprise)
        
    }
    
}
