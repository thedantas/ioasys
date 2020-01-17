//
//  Observable+Retry.swift
//  ioasys
//
//  Created by Andre Costa Dantas on 17/01/20.
//  Copyright © 2020 Andre Costa Dantas. All rights reserved.
//

import Foundation
import RxSwift
import RxSwiftExt
import Moya

private var maxRetry: UInt = 3
private var initialRetry: Double = 4
private var multiplierRetry: Double = 2

public extension Observable {

    func retryWhenNeeded() -> Observable<Element> {
        return self
            .retry(
            
                .exponentialDelayed(maxCount: maxRetry, initial: initialRetry, multiplier: multiplierRetry), shouldRetry: {error in
                    guard let moyaError = error as? MoyaError else {
                        return false
                    }
                    if case let .underlying(error, _) = moyaError {
                        let error = (error as NSError)
                     
                        if error.domain == NSURLErrorDomain || 500...599 ~= error.code {
                
                            return true
                        }
                    }
                    return false
        })
    }
}


