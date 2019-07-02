//
//  TestStore.swift
//  
//
//  Created by Matěj Kašpar Jirásek on 02/07/2019.
//

import Elementary

final class TestStore<State, Action>: Store {

    private var state: State
    private let update: Update<State, Action>

    init(state: State, update: @escaping Update<State, Action>) {
        self.state = state
        self.update = update
    }

    func dispatch(_ action: Action) -> Call {
        return {
            self.state = self.update(self.state, action)
        }
    }
}
