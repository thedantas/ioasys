//
//  DefaultContainer.swift
//  ioasys
//
//  Created by Andre Costa Dantas on 17/01/20.
//  Copyright © 2020 Andre Costa Dantas. All rights reserved.
//

import Foundation
import Swinject
import Moya

final class DefaultContainer {
    
    let container: Container
    
    init() {
        self.container = Container()
        self.registerServices()
        self.registerViews()
        self.registerStorage()
    }
    
}

//MARK: Extesion Register
extension DefaultContainer {
    
    func registerViews() {
        
        self.container.register(SearchView.self) { resolver in
            SearchView(norrisStorage: resolver.resolve(NorrisStorage.self)!,
                       localStorage: resolver.resolve(UserDefaultsDataStorage.self)!)
        }
        
        self.container.register(MainView.self) { resolver in
            MainView(searchView: resolver.resolve(SearchView.self)!,
                repository: resolver.resolve(NorrisStorage.self)!,
                localStorage: resolver.resolve(UserDefaultsDataStorage.self)!)
        }
        
        self.container.register(SplashViewController.self) { _ in
            SplashViewController()
        }
        
    }
    
}

extension DefaultContainer {
    
    func registerServices() {
        self.container.register(NorrisService.self) { _ in
            let provider = MoyaProvider<FactsRouter>(plugins: self.getDefaultPlugins())
            return NorrisServiceRouterProvider(provider: provider)
        }
        
        self.container.register(NorrisStorage.self) { resolver in
            NorrisStorageImpl(
                service: resolver.resolve(NorrisService.self)!
            )
        }
    }
    
    func getDefaultPlugins() -> [PluginType] {
        #if DEBUG
            return [NetworkLoggerPlugin(verbose: true)]
        #else
            return []
        #endif
    }
    
}

extension DefaultContainer {
    
    func registerStorage() {
        
        self.container.register(UserDefaultsDataStorage.self) { _ in
            return UserDefaultsDataStorageImpl()
        }
        
    }
    
}


