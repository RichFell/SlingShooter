//
//  GameLogicManager.swift
//  SlingShotter
//
//  Created by Rich Fellure on 10/13/15.
//  Copyright © 2015 MobileMakers. All rights reserved.
//

import UIKit

@objc protocol GameLogicManagerDelegate {
    func gameLogicManager(manager: GameLogicManager, shouldShowTime timeString: String)
}

class GameLogicManager: NSObject {

    var delegate : GameLogicManagerDelegate?
    var timerActive =               false
    var spawnCount: Int64 =         0
    var killCount: NSInteger =      0
    static let singletonInstance =  GameLogicManager()
    private var timeString =        ""

    var timeRan: Int64 =            0 {
        didSet {
            timeString =    "\(timeRan) sec"
        }
    }

    var time : Int64 =              0 {
        didSet {
            if timerActive {
                timeRan = time
            }
        }
    }

    //MARK: Public Class methods
    class func sharedInstance()-> GameLogicManager {
        return GameLogicManager.singletonInstance
    }

    //MARK: Public Instance methods
    func beginAddingCrowsToScene(scene: SKScene) {
        let wait = SKAction.waitForDuration(4.5)
        let run = SKAction.runBlock { () -> Void in
            ++self.spawnCount
            for i in 0...self.spawnCount {
                self.addAnotherCrowAfterDelay(i, scene:scene)
            }
        }
        scene.runAction(SKAction.repeatActionForever(SKAction.sequence([wait,run])))
    }

    func startTimer(restart:Bool, onScene scene:SKScene) {
        let wait = SKAction.waitForDuration(NSTimeInterval(1.0))
        let run = SKAction.runBlock { () -> Void in
            self.time++
            self.delegate?.gameLogicManager(self, shouldShowTime: self.timeString)
        }
        scene.runAction(SKAction.repeatActionForever(SKAction.sequence([wait, run])))
    }

    func stopTimer() {
        timerActive = false
        checkIfLongestTime()
    }

    func reset() {
        time =      0
        timeRan =   0
        killCount = 0
    }

    //MARK: Private Instance methods
    private func addAnotherCrowAfterDelay(delay:Int64, scene: SKScene) {
        let wait = SKAction.waitForDuration(NSTimeInterval(delay))
        let run = SKAction.runBlock { () -> Void in
            BadGuy.dropABadGuyOnScene(scene)
        }
        scene.runAction(SKAction.sequence([wait, run]))
    }

    private func checkIfLongestTime() {
        if Int64(UserDefaults.longestTimeSurvived()) < timeRan {
            UserDefaults.setSecondsSurvived(Int(timeRan))
            GameCenterManager.sharedManager().reportTimePlayed(Int(timeRan), block: { (outcome, error) -> Void in
                //TODO: Do something with the error
            })
        }
    }
}
