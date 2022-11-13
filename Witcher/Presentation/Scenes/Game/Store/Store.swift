//
//  Store.swift
//  Witcher
//
//  Created by Maxim Terpugov on 02.11.2022.
//

import Foundation
import MommysEye

// Action access
protocol StoreInput {
    func dispatch(_ action: Action)
}

// Observers access
protocol StoreOutput {
    var state: Publisher<State> { get }
}


final class Store: StoreInput,
                   StoreOutput {
    
    //MARK: - Dependencies
    
    let state: Publisher<State>
    private let reducer: Reducer
    
    
    //MARK: - Init
    
    init(state: State,
         reducer: Reducer) {
        self.state = Publisher(value: state)
        self.reducer = reducer
    }
    
    
    //MARK: - Interface
    
    func dispatch(_ action: Action) {
        // Обновляем стейт в мейн потоке
        DispatchQueue.main.async {
            self.state.value = self.reducer.execute(action: action, state: self.state.value)
        }
    }
    
}
