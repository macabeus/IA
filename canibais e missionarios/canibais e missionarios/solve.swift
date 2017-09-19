//
//  solve.swift
//  canibais e missionarios
//
//  Created by Bruno Macabeus Aquino on 19/09/17.
//  Copyright © 2017 Bruno Macabeus Aquino. All rights reserved.
//

import Foundation

var visitedStates: [String: Int] = [:]
var customStack: [[Int]] = []

func solve(_ param: [Int]) {
    customStack.append(param)

    var lms: Int // Left Missionaries
    var lma: Int // Left Man Eaters
    var lbo: Int // Left Boat
    var rms: Int // Right Missionaries
    var rma: Int // Right Man Eaters
    var rbo: Int // Right Boat
    var lvl: Int // Stack Level
    while (customStack.count > 0) {
        var currentArr: [Int] = (customStack.popLast())!
        lms = currentArr[0]
        lma = currentArr[1]
        lbo = currentArr[2]
        rms = currentArr[3]
        rma = currentArr[4]
        rbo = currentArr[5]
        lvl = currentArr[6]
        let state = [lms, lma, lbo, rms, rma, rbo].flatMap({"\($0)"}).joined(separator: "")
        if (visitedStates[state] != 1) {
            print("\(lvl) || \(lms), \(lma), \(lbo), \(rms), \(rma), \(rbo) ->")

            if (rms == 3 && rma == 3) {
                print("<< -------------- Success!")
            }

            visitedStates[state] = 1

            if (rbo > 0 && rms > 1 && (rms + left01[3] == 0 || rms + left01[3] >= rma)) {
                customStack.append([lms + left01[0], lma + left01[1], lbo + left01[2], rms + left01[3], rma + left01[4], rbo + left01[5], lvl + 1])
            }
            if (rbo > 0 && rms > 0 && rms >= rma && (rms + left02[3] == 0 || rms + left02[3] >= rma)) {
                customStack.append([lms + left02[0], lma + left02[1], lbo + left02[2], rms + left02[3], rma + left02[4], rbo + left02[5], lvl + 1])
            }
            if (rbo > 0 && rma > 1 && (lma + left03[1] <= lms || lms == 0)) {
                customStack.append([lms + left03[0], lma + left03[1], lbo + left03[2], rms + left03[3], rma + left03[4], rbo + left03[5], lvl + 1])
            }
            if (rbo > 0 && rma > 0 && (lma + left04[1] <= lms || lms == 0)) {
                customStack.append([lms + left04[0], lma + left04[1], lbo + left04[2], rms + left04[3], rma + left04[4], rbo + left04[5], lvl + 1])
            }
            if (rbo > 0 && rms > 0 && rma > 0 && lma == lms) {
                customStack.append([lms + left05[0], lma + left05[1], lbo + left05[2], rms + left05[3], rma + left05[4], rbo + left05[5], lvl + 1])
            }
            if (lbo > 0 && lms > 1 && (lms + right01[0] == 0 || lms + right01[0] >= lma)) {
                customStack.append([lms + right01[0], lma + right01[1], lbo + right01[2], rms + right01[3], rma + right01[4], rbo + right01[5], lvl + 1])
            }
            if (lbo > 0 && lms > 0 && (lms + right02[0] == 0 || lms + right02[0] >= lma)) {
                customStack.append([lms + right02[0], lma + right02[1], lbo + right02[2], rms + right02[3], rma + right02[4], rbo + right02[5], lvl + 1])
            }
            if (lbo > 0 && lma > 1 && (rma + right03[4] <= rms || rms == 0)) {
                customStack.append([lms + right03[0], lma + right03[1], lbo + right03[2], rms + right03[3], rma + right03[4], rbo + right03[5], lvl + 1])
            }
            if (lbo > 0 && lma > 0 && (rma + right04[4] <= rms || rms == 0)) {
                customStack.append([lms + right04[0], lma + right04[1], lbo + right04[2], rms + right04[3], rma + right04[4], rbo + right04[5], lvl + 1])
            }
            if (lbo > 0 && lms > 0 && lma > 0 && lma == lms) {
                customStack.append([lms + right05[0], lma + right05[1], lbo + right05[2], rms + right05[3], rma + right05[4], rbo + right05[5], lvl + 1])
            }
        }
    }
}

