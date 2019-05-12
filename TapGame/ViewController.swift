//
//  ViewController.swift
//  TapGame
//
//  Created by Aleksandra Konopka on 09/05/2019.
//  Copyright © 2019 Aleksandra Konopka. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate, CanReceive {
    
    @IBOutlet var collectionView: UICollectionView!
    let defaults = UserDefaults.standard
    let dataFilePathRecord = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Records.plist")
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
    var records = [Record(time: Date(), score: 0 ),Record(time: Date(), score: 0),Record(time: Date(), score: 0 ),Record(time: Date(), score: 0),Record(time: Date(), score: 0 )]
    

    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
//        if records.count < 5
//        {
//        records = [Record(time: Date(), score: 0 ),Record(time: Date(), score: 0),Record(time: Date(), score: 0 ),Record(time: Date(), score: 0),Record(time: Date(), score: 0 )]
//        saveToChosenPlist(filePath: dataFilePathRecord!, table: records)
//        //loadData()
//        }
        print(NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).last! as String)
    }
    override func viewDidAppear(_ animated: Bool) {
        //loadData()
    }
    @IBAction func playButtonPressed(_ sender: Any) {
        performSegue(withIdentifier: "showGame", sender: self)
    }
    func saveToChosenPlist<T: Encodable>(filePath:URL, table: T)
    {
        let encoder = PropertyListEncoder()
        do {
            let data = try encoder.encode(table)
            try data.write(to:filePath)
        }
        catch {
            print("Error encoding item array \(error)")
        }
        print("Weszlo1")
    }
    func loadData()
    {
        if let data = try? Data(contentsOf: dataFilePathRecord!) {
            let decoder = PropertyListDecoder()
            do{
                records = try decoder.decode([Record].self, from: data)
                collectionView.reloadData()
            } catch{
                print("Error decoding item array: \(error)")
            }
        }
    }
    
}

