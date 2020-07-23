//
//  Permutations.swift
//  CSE438_FinalProject
//
//  Created by https://gist.github.com/proxpero/9fd3c4726d19242365d6
//https://gist.github.com/JadenGeller/6174b3461a34465791c5
//  Copyright © 2020 Tejas Prasad. All rights reserved.
//

import Foundation

extension Array {
    func decompose() -> (Iterator.Element, [Iterator.Element])? {
        guard let x = first else { return nil }
        return (x, Array(self[1..<count]))
    }
}

extension Array {
    var powerSet: [[Element]] {
        guard !isEmpty else { return [[]] }
        let tailPowerSet = Array(self[1...]).powerSet
        return tailPowerSet.map { [self[0]] + $0 } + tailPowerSet
    }
}

func between<T>(x: T, _ ys: [T]) -> [[T]] {
    guard let (head, tail) = ys.decompose() else { return [[x]] }
    return [[x] + ys] + between(x: x, tail).map { [head] + $0 }
}

func permutations<T>(xs: [T]) -> [[T]] {
    guard let (head, tail) = xs.decompose() else { return [[]] }
    return permutations(xs: tail).flatMap { between(x: head, $0) }
}
