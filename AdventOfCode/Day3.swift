//
//  Day3.swift
//  AdventOfCode
//
//  Created by Johnny Slagle on 12/13/15.
//  Copyright © 2015 Johnny Slagle. All rights reserved.
//

import Foundation

// Note: I am using NSObject to override now NSCountedSet equates and compares this class
class House: NSObject { // Equatable, Hashable {
    var x: Int = 0
    var y: Int = 0
    
    override var hashValue: Int {
        return x ^ y
    }
    
    override func isEqual(object: AnyObject?) -> Bool {
        // for isEqual:
        if let house = object as? House {
            return house == self // just use our "==" function
        } else {
            return false
        }
    }
}

// MARK:- Equatable
func ==(left: House, right: House) -> Bool {
    return (left.x == right.x) && (left.y == right.y)
}


class Day3: Day {
    override func part1() -> Any {
        let instructions = input()!
        let countable = NSCountedSet()
//        countable.addObject(House())
//        countable.addObject(House())
//        countable.addObject(House())
//        print(countable.countForObject(House()))
        
        var x = 0, y = 0
        
        for c in instructions.characters {
            switch c {
            case "^":
                y++
            case "v":
                y--
            case "<":
                x--
            case ">":
                x++
            default:
                break
            }
        }
        
        // right here needing to finish the rest of the problem. I need to actually keep track of the presents next
        
        return ""
    }
    
    override func part2() -> Any {
        return ""
    }
}