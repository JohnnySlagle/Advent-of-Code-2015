//
//  Day5.swift
//  AdventOfCode
//
//  Created by Johnny Slagle on 12/13/15.
//  Copyright © 2015 Johnny Slagle. All rights reserved.
//

import Foundation

class Day5: Day {
    
    override func part1() -> Any {
        let words = input()?.componentsSeparatedByCharactersInSet(.newlineCharacterSet()) ?? []
        return words.filter { word -> Bool in
            
            let word_range = NSMakeRange(0, word.characters.count)
            
            // Check naughty words
//            let naughty_regex = try! NSRegularExpression(pattern: "(ab|cd|pq|xy){1,}", options: NSRegularExpressionOptions())
//            let naughty = naughty_regex.matchesInString(word, options: .ReportCompletion, range: word_range)
//            guard naughty.count == 0 else {
//                return false
//            }
            
            guard word.matches("(ab|cd|pq|xy){1,}") == 0 else {
                return false
            }
            
            // At least 3 vowels
//            let vowel_regex = try! NSRegularExpression(pattern: "[aeiou]", options: NSRegularExpressionOptions())
//            let vowels = vowel_regex.matchesInString(word, options: .ReportCompletion, range: word_range)
//            guard vowels.count >= 3 else {
//                return false
//            }
            
            guard word.matches("[aeiou]") >= 3 else {
                return false
            }
            
            // At least a double letter
//            let double_regex = try! NSRegularExpression(pattern: "([a-z])\\1", options: NSRegularExpressionOptions())
//            let doubles = double_regex.matchesInString(word, options: .ReportCompletion, range: word_range)
//            guard doubles.count >= 1 else {
//                return false
//            }
            
            guard word.matches("([a-z])\\1") >= 1 else {
                return false
            }
            
            return true
        }.count
    }
    
    override func part2() -> Any {
        let words = input()?.componentsSeparatedByCharactersInSet(.newlineCharacterSet()) ?? []
        return words.filter { word -> Bool in

            let word_range = NSMakeRange(0, word.characters.count)
            
            // pair of any two letters that appears at least twice in the string without overlapping
            
            // At least one letter which repeats with exactly one letter between them
            let letter_hug_regex = try! NSRegularExpression(pattern: "([a-z]{1})[a-z]{1}\\1", options: NSRegularExpressionOptions())
            let letter_hugs = letter_hug_regex.matchesInString(word, options: .ReportCompletion, range: word_range)
            guard letter_hugs.count >= 1 else {
                return false
            }
            
            return true
        }.count
    }
}

extension String {
    func matches(pattern: String) -> Int {
        if let regex = try? NSRegularExpression(pattern: pattern, options: NSRegularExpressionOptions()) {
            return regex.matchesInString(self, options: .ReportCompletion, range: NSMakeRange(0, self.characters.count)).count
        }
        return 0
    }
}