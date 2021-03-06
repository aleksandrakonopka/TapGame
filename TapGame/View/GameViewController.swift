//
//  GameViewController.swift
//  TapGame
//
//  Created by Aleksandra Konopka on 09/05/2019.
//  Copyright © 2019 Aleksandra Konopka. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {
    
    var saveProvider: SaveProviding?
    var delegate : Receiving?
    let defaults = UserDefaults.standard
    let dataFilePathRecord = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Records.plist")
    var records = [Record]()
    var dateBeginning = Date() // rozpoczęcie gry = kliknięcie Play
    var messages = ["3","2","1","PLAY!"]
    var index = 0
    var score = 0
    var timeClock = 5
    var fontSize = 21
    @IBOutlet var timeLeftLabel: UILabel!
    @IBOutlet var scoreLabel: UILabel!
    @IBOutlet var timerLabel: UILabel!
    @IBOutlet var hurryUpLabel: UILabel!
    var timer = Timer()
    var timerClock = Timer()
    var playTimer = Timer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        saveProvider = SaveProvider()
        hurryUpLabel.isHidden = true
        timeLeftLabel.isHidden = true
        scoreLabel.isHidden = true
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(action), userInfo: nil, repeats: true)
    }
    
    func addAlert()
    {
        var placeInRankingIndex = 5
        let alert = UIAlertController(title: "Good job", message: "Your score is : \(score)", preferredStyle: .alert )
        for recordScore in self.records // jeżeli ma sie score wiekszy niz dana liczba osob z rankingu to jest sie na 5 - dana liczba osób + 1 miejscu
        {
            if self.score > recordScore.score
            {
                placeInRankingIndex = placeInRankingIndex - 1
                
            }
        }
        let ok = UIAlertAction(title: "OK", style: .default){ action in
            if placeInRankingIndex < 5 // jestes na liscie wyników
            {
                self.records.insert(Record(time: self.dateBeginning, score: self.score), at: placeInRankingIndex)
                self.records.removeLast()
                self.saveProvider?.saveToChosenPlist(table: self.records)
            }
            self.delegate?.dataReceived(data: self.records)
            self.dismiss(animated: true, completion: nil)
            self.dismiss(animated: true, completion: nil)
        }
        alert.addAction(ok)
        if score == 0
        {
            alert.title = "Oh no! You got zero points!"
            alert.message = "You were supposed to tap on the screen! Try again!"
        }
        if placeInRankingIndex < 5
        {
            alert.title = "New high score!"
            alert.message = "Your score \(score)! Position in ranking :\(placeInRankingIndex+1) "
        }
        self.present(alert,animated: true, completion: nil)
    }
    @objc func moveClock()
    {
        timeClock = timeClock - 1
        if timeClock > 0
        {
            timeLeftLabel.text = "Time left: \(timeClock)"
        }
        else
        {
            timerClock.invalidate()
            timeLeftLabel.text = "Time left: 0"
            let oneTap = (self.view.gestureRecognizers?.filter(){$0 is UITapGestureRecognizer}.first!)!
            self.view.removeGestureRecognizer(oneTap)
            addAlert()
        }
    }
    @objc func tappedOnce(_ tap : UIGestureRecognizer)
    {
      score = score + 1
      scoreLabel.text = "\(score)"
      fontSize = fontSize + 1
      scoreLabel.font = scoreLabel.font.withSize(CGFloat(fontSize))
    }
    @objc func action()
    {
        index = index + 1
        if index < 4
        {
            timerLabel.text = messages[index]
        }
        else
        {
            timer.invalidate()
            playTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(playAction), userInfo: nil, repeats: false)
        }
    }
    @objc func playAction()
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
