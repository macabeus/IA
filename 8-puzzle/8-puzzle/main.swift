//
//  main.swift
//  8-puzzle
//
//  Created by Bruno Macabeus Aquino on 19/09/17.
//  Copyright © 2017 Bruno Macabeus Aquino. All rights reserved.
//

import Foundation

let initialColection = [Int](0...8)

func transformArrayToString(array: [Int]) -> String {
    var stringValue = ""
    for value in array {
        stringValue += String(value)
    }
    return stringValue
}

func distanceFromRightPosition(value: Int, index: Int) -> Int {
    let valueToBeComputed: Int
    if value == 0 {
        valueToBeComputed = 9
    } else {
        valueToBeComputed = value
    }
    let verticalDistance = abs((valueToBeComputed - 1) / 3 - index / 3)
    let horizontalDistance = abs((valueToBeComputed - 1) % 3 - index % 3)
    return verticalDistance + horizontalDistance
}

func h(state: [Int]) -> Int {
    var accumulatedDistance: Int = 0
    for (index, value) in state.enumerated() {
        accumulatedDistance += distanceFromRightPosition(value: value, index: index)
    }
    return accumulatedDistance
}

func aStar() -> Int {
    var counter: Int = 0
    while (statesQueue.count > 0) {
        var bestState: Int = 0
        var minValue: Int = 999999
        for (index, stateNode) in statesQueue.enumerated() {
            let totalStatePrice = g(state: stateNode.state)
            if totalStatePrice < minValue {
                bestState = index
                minValue = totalStatePrice
            }
        }
        let currentStateNode = statesQueue[bestState]

        if allCorrect(state: currentStateNode.state) {
            break
        }
        for move in validMoves {
            let nextState = move(currentStateNode.state)
            let nextStateString = transformArrayToString(array: nextState)
            if nextState != currentStateNode.state && visitedStates[nextStateString] == nil {
                let fValue: Int = f(currentState: currentStateNode.state, nextState: nextState)
                if statesPrice[nextStateString] == nil {
                    statesPrice[nextStateString] = fValue
                    statesQueue.append(StateNode(myState: nextState, myParent: currentStateNode))
                } else {
                    if statesPrice[nextStateString]! > fValue {
                        statesPrice[nextStateString] = fValue
                    }
                }
            }
        }
        visitedStates[transformArrayToString(array: currentStateNode.state)] = 1
        statesQueue.remove(at: bestState)
        counter += 1
    }
    return counter
}

func setup(state: [Int]) {
    statesQueue.append(StateNode(myState: state, myParent: nil))
    let stateString: String = transformArrayToString(array: state)
    statesPrice[stateString] = 0
}

for i in 0...150 {
    states.append(validMoves[i % 4](states.last!))
}

setup(state: states.last!)

print("iteracoes: \(aStar())\n")

print("---------------\n")

func resultFilter() {
    while (!allCorrect(state: statesQueue.last!.state)) {
        statesQueue.removeLast()
    }

    var currentStateNode: StateNode? = statesQueue.last
    var orderedStackNode: [StateNode] = []

    while (currentStateNode != nil) {
        orderedStackNode.append(currentStateNode!)
        currentStateNode = currentStateNode?.parentState
    }

    while (orderedStackNode.count > 0) {
        printState(state: orderedStackNode.removeLast().state)
        print("")
    }
}

resultFilter()
