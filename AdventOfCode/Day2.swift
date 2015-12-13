//
//  Day2.swift
//  AdventOfCode
//
//  Created by Johnny Slagle on 12/13/15.
//  Copyright © 2015 Johnny Slagle. All rights reserved.
//

import Foundation

// surface area: 2*l*w + 2*w*h + 2*h*l
// slack: the area of the smallest side.

let l = 0
let w = 1
let h = 2


class Day2: Day {
    func part1() -> Any {
        var paperSqFt = 0
        if let presents = input()?.componentsSeparatedByCharactersInSet(.newlineCharacterSet()) {
            for present in presents {
                if let sides = parseSides(present) {
                    paperSqFt += area(sides)
                }
            }
        }
        return paperSqFt
    }
    
    func part2() -> Any {
        var ribbonFt = 0
        if let presents = input()?.componentsSeparatedByCharactersInSet(.newlineCharacterSet()) {
            for present in presents {
                if var sides = parseSides(present) {
                    let bowLength = sides.reduce(1, combine: *)
                    ribbonFt += bowLength
                    
                    let smallIndex = minSide(sides)
                    let smallNo = sides.removeAtIndex(smallIndex)
                    let wrap = (2 * smallNo) + (2 * sides[minSide(sides)])
                    ribbonFt += wrap
                }
            }
        }
        return ribbonFt
    }
    
    func input() -> String? {
        return try? String(contentsOfFile: "/Users/Johnny/Desktop/AdventOfCode/AdventOfCode/Day2-Input")
    }
    
    func parseSides(dimensions: String) -> [Int]? {
        return dimensions.componentsSeparatedByString("x").map { (text: String) -> Int in
            Int(text) ?? 0
        }
    }
    
    func area(sides: [Int]) -> Int {
        let top_bottom = 2 * sides[l] * sides[w]
        let front_back = 2 * sides[w] * sides[h]
        let left_right = 2 * sides[h] * sides[l]
        let slack = (min(top_bottom / 2, front_back / 2, left_right / 2))
        
        return top_bottom + front_back + left_right + slack
    }
    
    func minSide(sides: [Int]) -> Int {
        guard sides.count > 1 else {
            return 0
        }
        
        var index = 0, min = sides[l]
        for no in 0..<sides.count {
            if (sides[no] < min) {
                index = no
                min = sides[no]
            }
        }
        
        return index
    }
}




// It'd be cool to get the input with an api
//let url = NSURL(string: "http://adventofcode.com/day/2/input")
//let task = NSURLSession.sharedSession().dataTaskWithURL(url!) {(data, response, error) in
//    print(String(data: data!, encoding: NSUTF8StringEncoding))
//}
//task.resume()



// Notes: I wanted to use tuples but decided not to because I wanted to use .map

// Convert Array to Tuple
//    let tuple = UnsafeMutablePointer<TupleType>(malloc(Int(sizeof(TupleType))))
//    memcpy(tuple, (sides ?? []), Int((sides ?? []).count))

// Smallest element in an array
// sides.minElement() works and something like sides.reduce(Int.max) {min($0, $1)}, too
