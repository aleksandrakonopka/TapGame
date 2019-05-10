//
//  GameViewController.swift
//  TapGame
//
//  Created by Aleksandra Konopka on 09/05/2019.
//  Copyright © 2019 Aleksandra Konopka. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {
    var messages = ["3","2","1","0","PLAY!"]
    var index = 0
    var score = 0
    @IBOutlet var scoreLabel: UILabel!
    @IBOutlet var timerLabel: UILabel!
    @IBOutlet var hurryUpLabel: UILabel!
    var timer = Timer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hurryUpLabel.isHidden = true
        scoreLabel.isHidden = true
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(action), userInfo: nil, repeats: true)
        var gameTimer = Timer.scheduledTimer(timeInterval: 7, target: self, selector: #selector(runTimedCode), userInfo: nil, repeats: false)
        // Do any additional setup after loading the view.
        
    }
    @objc func tappedOnce(_ tap : UIGestureRecognizer)
    {
     score = score + 1
     scoreLabel.text = "Score: \(score)"
    }
    @objc func action()
    {
        index = index + 1
        if index < 5
        {
        timerLabel.text = messages[index]
        }
        else
        {
            timer.invalidate()
            timerLabel.isHidden = true
            hurryUpLabel.isHidden = false
            scoreLabel.isHidden = false
            let oneTap = UITapGestureRecognizer(target: self, action: #selector(tappedOnce(_:)))
            self.view.addGestureRecognizer(oneTap)
        }
    }
    @objc func runTimedCode()
    {
        let oneTap = (self.view.gestureRecognizers?.filter(){$0 is UITapGestureRecognizer}.first!)!
        self.view.removeGestureRecognizer(oneTap)
        self.dismiss(animated: true, completion: nil)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
