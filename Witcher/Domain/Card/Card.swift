//
//  Card.swift
//  Witcher
//
//  Created by Maxim Terpugov on 02.11.2022.
//


struct Card: Equatable {
    
    let id: Int
    let type: `Type`
    
    enum `Type` {
        
        struct Params {
            let damage: Int
            // etc...
        }
        
        // у каждой карты обязательное поле Params
        case warrior(_ params: Params)
        // etc...
        
        func params() -> Params {
            switch self {
            case .warrior(let params):
                return params
            }
        }
    }
    
    // Equatable
    static func == (lhs: Card, rhs: Card) -> Bool {
        let result = lhs.id == rhs.id
        return result
    }
    
}
