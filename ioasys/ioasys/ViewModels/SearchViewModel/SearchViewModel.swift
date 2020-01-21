//
//  SearchViewModel.swift
//  ioasys
//
//  Created by Andre Costa Dantas on 17/01/20.
//  Copyright © 2020 Andre Costa Dantas. All rights reserved.
//

import RxSwift
import RxCocoa
import RxSwiftExt
import RxSwiftUtilities

class SearchViewModel {
    
    let recentSearch: Driver<[String]>
    let isRecentSearchHidden: Driver<Bool>
    
    let isLoading: Driver<Bool>
    
    let disposeBag = DisposeBag()
    
    init(enterpriseStorage: EnterpriseStorage,
         localStorage: UserDefaultsDataStorage) {
        
        let loadingIndicator = ActivityIndicator()
        self.isLoading = loadingIndicator.asDriver()
            
        self.recentSearch = localStorage
            .lastSearch
            .asDriver(onErrorJustReturn: [])
        
        self.isRecentSearchHidden = self.recentSearch
            .map { $0.count == 0 }
            .startWith(true)
        

    }
}
