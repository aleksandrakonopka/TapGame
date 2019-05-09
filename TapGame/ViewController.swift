//
//  ViewController.swift
//  TapGame
//
//  Created by Aleksandra Konopka on 09/05/2019.
//  Copyright © 2019 Aleksandra Konopka. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
//        var gameTimer = Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(runTimedCode), userInfo: nil, repeats: true)
        
        // Do any additional setup after loading the view.
    }
//    @objc func runTimedCode()
    @IBAction func playButtonPressed(_ sender: Any) {
        performSegue(withIdentifier: "showGame", sender: self)
    }
    //    {
//        print("dupa")
//    }

}

