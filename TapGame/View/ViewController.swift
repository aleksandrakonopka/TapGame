//
//  ViewController.swift
//  TapGame
//
//  Created by Aleksandra Konopka on 09/05/2019.
//  Copyright © 2019 Aleksandra Konopka. All rights reserved.
//

import UIKit

class ViewController: UIViewController/*,UICollectionViewDataSource,UICollectionViewDelegate*/,Receiving {
    var saveProvider: SaveProviding?
    @IBOutlet var collectionView: UICollectionView!
    let defaults = UserDefaults.standard
    let dataFilePathRecord = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Records.plist")
      var records = [Record(time: Date(), score: 0 ),Record(time: Date(), score: 0),Record(time: Date(), score: 0 ),Record(time: Date(), score: 0),Record(time: Date(), score: 0 )]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        saveProvider = SaveProvider()
        if saveProvider!.loadFromChosenPlist().count > 0
        {
            records = saveProvider!.loadFromChosenPlist()
        }
        collectionView.reloadData()
        print(NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).last! as String)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showGame"
        {
            let secondVC = segue.destination as! GameViewController
            secondVC.records = records
            secondVC.delegate=self
        }
    }
    
    func dataReceived(data: [Record]) {
        records  =  data
        collectionView.reloadData()
    }
    
    @IBAction func playButtonPressed(_ sender: Any) {
        performSegue(withIdentifier: "showGame", sender: self)
    }
}

extension ViewController : UICollectionViewDataSource,UICollectionViewDelegate
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return records.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionViewCell
        if records[indexPath.row].score > 0
        {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MM-dd-yyyy HH:mm:ss"
            let dateFormated = dateFormatter.string(from:records[indexPath.row].time)
            cell.label.text = "Score: \(records[indexPath.row].score) Time: \(dateFormated)"
            cell.label.textColor = .gray
        }
        else
        {
            cell.label.text = ""
        }
        
        return cell
    }
}
