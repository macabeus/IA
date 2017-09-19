//
//  move.swift
//  8-puzzle
//
//  Created by Bruno Macabeus Aquino on 19/09/17.
//  Copyright © 2017 Bruno Macabeus Aquino. All rights reserved.
//

import Foundation

func moveUp(state: [Int]) -> [Int] {
    let zeroIndex: Int = zero(state: state)
    if (zeroIndex > 2) {
        return createNewState(state: state, zeroIndex: zeroIndex, indexToChange: zeroIndex - 3)
    } else {
        return state
    }
}

func moveDown(state: [Int]) -> [Int] {
    let zeroIndex: Int  = zero(state: state)
    if (zeroIndex < 5) {
        return createNewState(state: state, zeroIndex: zeroIndex, indexToChange: zeroIndex + 3)
    } else {
        return state
    }
}

func moveLeft(state: [Int]) -> [Int] {
    let zeroIndex: Int = zero(state: state)
    if (zeroIndex % 3 > 0) {
        return createNewState(state: state, zeroIndex: zeroIndex, indexToChange: zeroIndex - 1)
    } else {
        return state
    }
}

func moveRight(state: [Int]) -> [Int] {
    let zeroIndex: Int = zero(state: state)
    if (zeroIndex % 3 < 2) {
        return createNewState(state: state, zeroIndex: zeroIndex, indexToChange: zeroIndex + 1)
    } else {
        return state
    }
}

let validMoves: [([Int]) -> [Int]] = [moveUp, moveRight, moveDown, moveLeft]
