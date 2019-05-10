//
//  GameViewController.swift
//  TapGame
//
//  Created by Aleksandra Konopka on 09/05/2019.
//  Copyright © 2019 Aleksandra Konopka. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {
    var messages = ["3","2","1"/*,"PLAY!"*/]
    var index = 0
    var score = 0
    var timeClock = 5
    var timerPlayIndex = 0
 
    @IBOutlet var timeLeftLabel: UILabel!
    @IBOutlet var scoreLabel: UILabel!
    @IBOutlet var timerLabel: UILabel!
    @IBOutlet var hurryUpLabel: UILabel!
    var timer = Timer()
    var timerClock = Timer()
    var playTimer = Timer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hurryUpLabel.isHidden = true
        timeLeftLabel.isHidden = true
        scoreLabel.isHidden = true
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(action), userInfo: nil, repeats: true)
        //var gameTimer = Timer.scheduledTimer(timeInterval: 9, target: self, selector: #selector(runTimedCode), userInfo: nil, repeats: false)
        // Do any additional setup after loading the view.
        
    }
    
    func addAlert()
    {
        let alert = UIAlertController(title: "The end", message: "Game has finished", preferredStyle: .alert )

        let ok = UIAlertAction(title: "OK", style: .default){ action in
           self.dismiss(animated: true, completion: nil)
           self.dismiss(animated: true, completion: nil)
                }
        
        alert.addAction(ok)
        self.present(alert,animated: true, completion: nil)
    }


    @objc func moveClock()
    {
        timeClock = timeClock - 1
        if timeClock > -1
        {
            timeLeftLabel.text = "Time left: \(timeClock)"
        }
        else
        {
            timerClock.invalidate()
            let oneTap = (self.view.gestureRecognizers?.filter(){$0 is UITapGestureRecognizer}.first!)!
            self.view.removeGestureRecognizer(oneTap)
            //self.dismiss(animated: true, completion: nil)
            addAlert()
        }
        
    }
    @objc func tappedOnce(_ tap : UIGestureRecognizer)
    {
     score = score + 1
     scoreLabel.text = "Score: \(score)"
    }
    @objc func action()
    {
        index = index + 1
        if index < 3
        {
        timerLabel.text = messages[index]
        }
        else
        {
            timer.invalidate()
            playTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(playAction), userInfo: nil, repeats: true)
        }
    }
    @objc func playAction()
    {
        timerPlayIndex = timerPlayIndex + 1
        if timerPlayIndex < 2
        {
            timerLabel.text = "PLAY!"
        }
        else
        {
        playTimer.invalidate()
        timerLabel.isHidden = true
        hurryUpLabel.isHidden = false
        scoreLabel.isHidden = false
        timeLeftLabel.isHidden = false
        let oneTap = UITapGestureRecognizer(target: self, action: #selector(tappedOnce(_:)))
        self.view.addGestureRecognizer(oneTap)
        timerClock = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(moveClock), userInfo: nil, repeats: true)
        }

    }
    
   // @objc func runTimedCode()
   // {
//        let oneTap = (self.view.gestureRecognizers?.filter(){$0 is UITapGestureRecognizer}.first!)!
//        self.view.removeGestureRecognizer(oneTap)
//        self.dismiss(animated: true, completion: nil)
   // }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
