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
    @IBOutlet var timerLabel: UILabel!
    @IBOutlet var hurryUpLabel: UILabel!
    var timer = Timer()
    override func viewDidLoad() {
        super.viewDidLoad()
       hurryUpLabel.isHidden = true
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(action), userInfo: nil, repeats: true)
        var gameTimer = Timer.scheduledTimer(timeInterval: 7, target: self, selector: #selector(runTimedCode), userInfo: nil, repeats: true)
        // Do any additional setup after loading the view.
        
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
        }
    }
    @objc func runTimedCode()
    {
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
