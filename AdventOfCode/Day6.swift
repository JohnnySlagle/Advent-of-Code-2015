//
//  Day6.swift
//  AdventOfCode
//
//  Created by Johnny Slagle on 12/16/15.
//  Copyright © 2015 Johnny Slagle. All rights reserved.
//

import Foundation

enum Instructions: String {
    case TurnOn = "turn on"
    case TurnOff = "turn off"
    case Toggle = "toggle"
    
    init(prefixedString: String) {
        if prefixedString.hasPrefix(Instructions.TurnOn.rawValue) {
            self = .TurnOn
        } else if prefixedString.hasPrefix(Instructions.Toggle.rawValue) {
            self = .Toggle
        } else { //if prefixedString.hasPrefix(Instructions.TurnOff.rawValue) {
            self = .TurnOff
        }
    }
}

enum Part: Int {
    case Part1
    case Part2
}

class Grid {
    var lights : [[Int]] = Array(count: 1000, repeatedValue: Array(count: 1000, repeatedValue: 0))
    
    func adjust(top_left: (x: Int, y: Int), bottom_right: (x: Int, y: Int), instructions: Instructions = .TurnOff, part: Part = .Part1) {
        for (var y = top_left.y; y <= bottom_right.y; y++) {
            for (var x = top_left.x; x <= bottom_right.x; x++) {
                switch part {
                case .Part1:
                    part1(x: x, y: y, instructions: instructions)
                case .Part2:
                    part2(x: x, y: y, instructions: instructions)
                }
            }
        }
    }
    
    func part1(x x: Int, y: Int, instructions: Instructions) {
        switch instructions {
        case .TurnOff:
            lights[y][x] = 0
        case .TurnOn:
            lights[y][x] = 1
        case .Toggle:
            lights[y][x] = (lights[y][x] == 0) ? 1 : 0
        }
    }
    
    func part2(x x: Int, y: Int, instructions: Instructions) {
        switch instructions {
        case .TurnOff:
            lights[y][x] -= 1
            lights[y][x] = max(lights[y][x], 0)
        case .TurnOn:
            lights[y][x] += 1
        case .Toggle:
            lights[y][x] += 2
        }
    }
}

class Day6: Day {
    func run_lights(part: Part = .Part1) -> Int {
        let grid = Grid()
        let instructions = input()?.componentsSeparatedByString("\n") ?? []
        for instructionString in instructions {
            var coordinates: [NSTextCheckingResult] = instructionString.matches("[0-9]+")
            let top_left = (instructionString.substringInt(coordinates[0]), instructionString.substringInt(coordinates[1]))
            let bottom_right = (instructionString.substringInt(coordinates[2]), instructionString.substringInt(coordinates[3]))
            grid.adjust(top_left, bottom_right: bottom_right, instructions: Instructions(prefixedString: instructionString), part: part)
        }
        
        return grid.lights.flatMap{$0}.reduce(0, combine: +)
    }
    
    override func part1() -> Any {
        return run_lights(.Part1)
    }
    
    override func part2() -> Any {
        return run_lights(.Part2)
    }

}

extension String {
    func substringInt(result: NSTextCheckingResult) -> Int {
        return Int((self as NSString).substringWithRange(result.range)) ?? 0
    }
}