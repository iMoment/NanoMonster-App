//
//  ViewController.swift
//  NanoMonster
//
//  Created by Stanley Pan on 1/30/16.
//  Copyright © 2016 Stanley Pan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var monsterImage: MonsterImage!
    @IBOutlet weak var foodImage: DragImage!
    @IBOutlet weak var heartImage: DragImage!
    @IBOutlet weak var skullPenalty1: UIImageView!
    @IBOutlet weak var skullPenalty2: UIImageView!
    @IBOutlet weak var skullPenalty3: UIImageView!
    
    let DIM_ALPHA: CGFloat = 0.2
    let OPAQUE: CGFloat = 1.0
    let MAX_PENALTIES = 3
    
    var penalties = 0
    var timer: NSTimer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        foodImage.dropTarget = monsterImage
        heartImage.dropTarget = monsterImage
        
        skullPenalty1.alpha = DIM_ALPHA
        skullPenalty2.alpha = DIM_ALPHA
        skullPenalty3.alpha = DIM_ALPHA
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "itemDroppedOnCharacter:", name: "onTargetDropped", object: nil)
        
        startTimer()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func itemDroppedOnCharacter(notif: AnyObject) {
        print("ITEM DROPPED ON CHARACTER")
    }
    
    func startTimer() {
        if timer != nil {
            timer.invalidate()
        }
        
        timer = NSTimer.scheduledTimerWithTimeInterval(4.0, target: self, selector: "changeGameState", userInfo: nil, repeats: true)
    }
    
    func changeGameState() {
        penalties++
        
        if penalties == 1 {
            skullPenalty1.alpha = OPAQUE
            skullPenalty2.alpha = DIM_ALPHA
        } else if penalties == 2 {
            skullPenalty2.alpha = OPAQUE
            skullPenalty3.alpha = DIM_ALPHA
        } else if penalties >= 3 {
            skullPenalty3.alpha = OPAQUE
        } else {
            skullPenalty1.alpha = DIM_ALPHA
            skullPenalty2.alpha = DIM_ALPHA
            skullPenalty3.alpha = DIM_ALPHA
        }
        
        if penalties >= MAX_PENALTIES {
            gameOver()
        }
    }
    
    func gameOver() {
        timer.invalidate()
        monsterImage.playDeathAnimation()
    }

}

