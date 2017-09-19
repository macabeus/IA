//
//  state.swift
//  8-puzzle
//
//  Created by Bruno Macabeus Aquino on 19/09/17.
//  Copyright © 2017 Bruno Macabeus Aquino. All rights reserved.
//

import Foundation

class StateNode {
    var state: [Int]
    var parentState: StateNode?

    init(myState: [Int], myParent: StateNode?) {
        state = myState
        parentState = myParent
    }
}

var visitedStates: [String: Int] = [:]
var statesPrice: [String: Int] = [:]
var statesQueue: [StateNode] = []
var states: [[Int]] = []

states.append(initialColection)

func zero(state: [Int]) -> Int {
    var zeroIndex = 0
    for (index, value) in state.enumerated() {
        if value == 0 {
            zeroIndex = index
        }
    }
    return zeroIndex
}

func createNewState(state: [Int], zeroIndex: Int, indexToChange: Int) -> [Int] {
    var newState = state
    newState[indexToChange] = state[zeroIndex]
    newState[zeroIndex] = state[indexToChange]
    return newState
}

func allCorrect(state: [Int]) -> Bool {
    for (index, value) in state.enumerated() {
        if index != value - 1 {
            if index == 8 && value == 0 {
                return true
            }
            return false
        }
    }
    return true
}

func printState(state: [Int]) {
    for i in 0...2 {
        for j in 0...1 {
            print(state[i * 3 + j], terminator: " ")
        }
        print (state[i * 3 + 2])
    }
}

func g(state: [Int]) -> Int {
    return statesPrice[transformArrayToString(array: state)] ?? 0
}

func f(currentState: [Int], nextState: [Int]) -> Int {
    return g(state: currentState) + h(state: nextState)
}
