//
//  ViewController.swift
//  Art Book Core Data
//
//  Created by Md AfzaL Hossain on 3/15/17.
//  Copyright © 2017 Md AfzaL Hossain. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    var names = [String]()
    var artists = [String]()
    var years = [Int]()
    var images = [UIImage]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tableView.delegate = self
        tableView.dataSource = self
        retriveData()
    }
    
//    override func viewDidAppear(_ animated: Bool) {
//        retriveData()
//        tableView.reloadData()
//    }
    
    func retriveData() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Paintings")
        request.returnsObjectsAsFaults = false
        do {
            let results = try context.fetch(request)
            if results.count > 0 {
                for result in results as! [NSManagedObject] {
                    if let name = result.value(forKey: "name") as? String {
                        self.names.append(name)
                    }
                    if let artist = result.value(forKey: "artist") as? String {
                        self.artists.append(artist)
                    }
                    if let year = result.value(forKey: "year") as? Int {
                        self.years.append(year)
                    }
                    if let imgData = result.value(forKey: "image") as? Data {
                        self.images.append(UIImage(data: imgData)!)
                    }
                }
            }
        }catch {
            print(error.localizedDescription)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return names.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? ArtBookCell {
            cell.nameLbl.text = names[indexPath.row]
            cell.artistLbl.text = artists[indexPath.row]
            cell.yearLbl.text = String(years[indexPath.row])
            cell.imgView.image = images[indexPath.row]
            return cell
        }else {
            return UITableViewCell()
        }
    }


    @IBAction func addBtn(_ sender: Any) {
        performSegue(withIdentifier: "toPaintingVC", sender: nil)
    }

}

