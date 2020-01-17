//
//  UserDefaultDataStorage.swift
//  ioasys
//
//  Created by Andre Costa Dantas on 17/01/20.
//  Copyright © 2020 Andre Costa Dantas. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

protocol UserDefaultsDataStorage: class {
    var lastSearch: Observable<[String]> { get }
    func addSearch(_ string: String)
}
