//
//  ViewController.swift
//  TapGame
//
//  Created by Aleksandra Konopka on 09/05/2019.
//  Copyright © 2019 Aleksandra Konopka. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate {
    
    @IBOutlet var collectionView: UICollectionView!
    let defaults = UserDefaults.standard
    let dataFilePathRecord = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Records.plist")
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return records.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionViewCell
        cell.label.text = "Score: \(records[indexPath.row].score) Time: \(records[indexPath.row].time)"
        return cell
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showGame"
        {
            let secondVC = segue.destination as! GameViewController
            secondVC.records = records
        }
    }
    
    var records = [Record(time: Date(), score: 11 ),Record(time: Date(), score: 12)]
    

    override func viewDidLoad() {
        super.viewDidLoad()
        //loadData()
        //saveToChosenPlist(filePath: dataFilePathRecord!, table: records)
        print(NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).last! as String)
    }
    override func viewDidAppear(_ animated: Bool) {
        loadData()
    }
    @IBAction func playButtonPressed(_ sender: Any) {
        performSegue(withIdentifier: "showGame", sender: self)
    }
//    func saveToChosenPlist<T: Encodable>(filePath:URL, table: T)
//    {
//        let encoder = PropertyListEncoder()
//        do {
//            let data = try encoder.encode(table)
//            try data.write(to:filePath)
//        }
//        catch {
//            print("Error encoding item array \(error)")
//        }
//        print("Weszlo1")
//    }
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

