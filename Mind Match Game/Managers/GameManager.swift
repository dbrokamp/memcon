//
//  GameManager.swift
//  Memory+Concentration
//
//  Created by Drew Brokamp on 10/29/20.
//

import SpriteKit
import GameplayKit

class GameManager {
    
    public var playAdCounter: Int {
        didSet {
            print("playAdCounter: \(playAdCounter)")
        }
    }
    public var score: Int {
        didSet {
            UserDefaults.standard.setValue(score, forKey: "score")
        }
    }
    public var level: Int {
        didSet {
            UserDefaults.standard.setValue(level, forKey: "level")
        }
    }
    
    public var numberOfMatchesMade: Int = 0
    public var numberOfMatchesPossible: Int = 15
    public var numberOfIncorrectMatches: Int = 0
    public var levelPointsCalc: Float = 0
    public var memorize: Int
    public var match: Int
    
    public var firstRun: Bool {
        didSet {
            UserDefaults.standard.setValue(firstRun, forKey: "firstRun")
        }
    }
    
    init() {
        score = UserDefaults.standard.integer(forKey: "score")
        level = UserDefaults.standard.integer(forKey: "level")
        firstRun =  false // UserDefaults.standard.bool(forKey: "firstRun")
        playAdCounter = 0
        
        if level == 0 {
            level = 1
        }
        
        print(firstRun)
        
        // MARK: Debug Times
        memorize = 16 - level
        match = 30 + memorize
        
    }
    
    public func resetGameVariables() {
        numberOfMatchesMade = 0
        numberOfIncorrectMatches = 0
        levelPointsCalc = 0
 
    }
    
    public func calculateLevelPoints() {

        
        // If player doesn't win the level, and their number of
        // correct matches exceeds or is equal to the number of
        // incorrect matches, their points are equal to the number of correct
        // matches they made
        if numberOfMatchesMade != numberOfMatchesPossible && numberOfMatchesMade >= numberOfIncorrectMatches {
            levelPointsCalc = Float(numberOfMatchesMade)
            
        // If the player doesn't win the level, and their number of incorrect
        // matches is greater than their number of correct matches, their
        // points are equal to half of their correct matches
        } else if numberOfMatchesMade != numberOfMatchesPossible && numberOfMatchesMade < numberOfIncorrectMatches {
            levelPointsCalc = (Float(numberOfMatchesMade) / 2)
            levelPointsCalc.round(.up)

        // If player wins the level and their number of incorrect matches
        // does not exceed the number of correct matches, their points are equal
        // to the number of correct matches + 15
        } else if numberOfMatchesMade == numberOfMatchesPossible && numberOfIncorrectMatches <= numberOfMatchesMade {
            levelPointsCalc = (Float(numberOfMatchesMade) + 15.0)
            
        // If player wins the level and their number of incorrect matches
        // exceeds the number of correct matches, their points are equal to
        // the total possible matches
        } else if numberOfMatchesMade == numberOfMatchesPossible && numberOfIncorrectMatches > numberOfMatchesMade {
            
        }
        score = score + Int(levelPointsCalc)
        

    }
    
    
    public func saveGame() {
        UserDefaults.standard.setValue(level, forKey: "level")
        UserDefaults.standard.setValue(score, forKey: "score")
    }
    
}
