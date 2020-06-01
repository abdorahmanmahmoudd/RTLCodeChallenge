//
//  BaseStateController.swift
//  RTLNewsApp
//
//  Created by Abdorahman on 30/05/2020.
//  Copyright © 2020 Abdorahman. All rights reserved.
//

import Foundation

class BaseStateController {
    
    // An enum to keep track of the current state of our requests
    enum State: Equatable {
        case initial
        case loading
        case error(error: Error?)
        case result
        
        static func == (lhs: State, rhs: State) -> Bool {
            switch (lhs, rhs) {
            case (.initial, .initial): return true
            case (.loading, .loading): return true
            case (.error, .error): return true
            case (.result, .result): return true
            default: return false
            }
        }
    }
    
    private(set) var state: State = .initial {
        didSet {
            refreshState()
        }
    }
    
    /// Callback which can be used to refresh the state
    var refreshState: () -> Void = {}
    
    func initialState() {
        state = .initial
    }
    
    func loadingState() {
        state = .loading
    }
    
    func errorState(_ error: Error?) {
        state = .error(error: error)
    }
    
    func resultState() {
        state = .result
    }
}
