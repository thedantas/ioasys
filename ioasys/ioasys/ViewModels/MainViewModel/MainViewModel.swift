//
//  MainViewModel.swift
//  ioasys
//
//  Created by Andre Costa Dantas on 17/01/20.
//  Copyright © 2020 Andre Costa Dantas. All rights reserved.
//


import RxSwift
import RxCocoa
import RxSwiftUtilities
import RxSwiftExt

class MainViewModel {
    
    let results: Driver<[Fact]>
    let searchError: Driver<Error>
    let isSearchShown: PublishSubject<Bool>
    
    let isFactsShown: Driver<Bool>
    let searchQuery: Observable<String>
    
    let viewState: Driver<ViewSelect>
    let isViewStateHidden: Driver<Bool>
    let isLoading: Driver<Bool>
    
    let disposeBag = DisposeBag()
    
    init(input:
            (search: Driver<String>,
            categorySelected: Driver<String>,
            recentSearchSelected: Driver<String>),
         norrisStorage: NorrisStorage,
         localStorage: UserDefaultsDataStorage) {
        
        let loadingIndicator = ActivityIndicator()
        self.isLoading = loadingIndicator
            .startWith(false)
            .asDriver()

        //search
        self.searchQuery = Observable.merge(
            input.search.asObservable(),
            input.categorySelected.asObservable(),
            input.recentSearchSelected.asObservable())
            .filter { !$0.isEmpty }
        
        let isSearchShown = PublishSubject<Bool>()
        self.isSearchShown = isSearchShown
        
        let searchResult = searchQuery
            .do(onNext: { search in
                //side effects are hiding search view and adding this search recent search storage
                isSearchShown.onNext(false)
                localStorage.addSearch(search)
            })
            .flatMapLatest { search in
                norrisStorage.search(search)
                    .asObservable()
                    .retryWhenNeeded()
                    .trackActivity(loadingIndicator)
                    .materialize() //converts error and onNext to events
            }.share()
        
        self.results = searchResult
            .elements()
            .startWith([])
            .asDriver(onErrorJustReturn: [])
        
        self.searchError = searchResult
            .errors()
            .asDriver(onErrorJustReturn: NorrisError())
        
        self.viewState = MainViewModel.viewState(results: results, error: searchError, isLoading: isLoading)
        
        let searchShownDriver = isSearchShown.asDriver(onErrorJustReturn: false)
        
        //weather state view is hidden or shown
        self.isViewStateHidden = Driver
            .combineLatest(self.results,
                           searchShownDriver,
                           self.isLoading) { results, searchShown, isLoading in
                if searchShown { return true }
                if isLoading { return false }
                if results.isEmpty { return false }
                return true
            }
            .asDriver(onErrorJustReturn: false)
        
        //the transparent background requires to hide the facts table
        //when search is showing or when there is some state to be shown
        self.isFactsShown = Driver.combineLatest(
            self.isViewStateHidden,
            searchShownDriver,
            self.isLoading) { viewStateHidden, searchShown, isLoading in
                if isLoading { return false }
                if searchShown { return false }
                if !viewStateHidden { return false}
                return true
            }
            .asDriver(onErrorJustReturn: false)
    }
    
    /// Returns Observable of ViewState, based on if there is any result, any errors or is loading
    ///
    /// - Parameters:
    ///   - results: Result of api jokes call
    ///   - error: Error thrown on api call
    ///   - isLoading: Wheater is loading or not
    /// - Returns: Observable already mapped to view state
    class func viewState(results: Driver<[Fact]>, error: Driver<Error>, isLoading: Driver<Bool>) -> Driver<ViewSelect> {
        //view states
        let isEmpty = results
            .filter { $0.isEmpty }
            .skip(1) //to avoid catching the "startWith"
            .map { _ in return ViewSelect.empty }
        
        let error = error
            .withLatestFrom(results) { error, results -> ViewSelect in
                    return ViewSelect.error(error)
        }
        
        let loading = isLoading
            .filter { $0 == true }
            .map { _ in return ViewSelect.loading }
        
        return Driver.merge(isEmpty,
                                 error,
                                 loading)
            .startWith(.start)
            .asDriver(onErrorJustReturn: ViewSelect.error(NorrisError()))

    }
}

