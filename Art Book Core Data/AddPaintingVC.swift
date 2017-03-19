//
//  AddPaintingVC.swift
//  Art Book Core Data
//
//  Created by Md AfzaL Hossain on 3/15/17.
//  Copyright © 2017 Md AfzaL Hossain. All rights reserved.
//

import UIKit
import CoreData

class AddPaintingVC: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var nameTxtFld: UITextField!
    @IBOutlet weak var artistTxtFld: UITextField!
    @IBOutlet weak var yearTxtFld: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        imgView.isUserInteractionEnabled = true
        let imgGesture = UITapGestureRecognizer(target: self, action: #selector(AddPaintingVC.imgTapped))
        imgView.addGestureRecognizer(imgGesture)
    }
    
    func imgTapped() {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        picker.sourceType = .photoLibrary
        self.present(picker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        imgView.image = info[UIImagePickerControllerEditedImage] as? UIImage
        dismiss(animated: true, completion: nil)
    }

    @IBAction func savePainting(_ sender: Any) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let artBook = NSEntityDescription.insertNewObject(forEntityName: "Paintings", into: context)
        
        artBook.setValue(nameTxtFld.text, forKey: "name")
        artBook.setValue(artistTxtFld.text, forKey: "artist")
        if let year = Int(yearTxtFld.text!) {
            artBook.setValue(year, forKey: "year")
        }
        
        let data = UIImageJPEGRepresentation(imgView.image!, 0.5)
        artBook.setValue(data, forKey: "image")
        
        do {
            try context.save()
            print("saved")
        }catch {
            print(error.localizedDescription)
        }
    }
    

}
