//
//  ProfileViewController.swift
//  Reserved
//
//  Created by Мария Коровина on 05/12/2019.
//  Copyright © 2019 Мария Коровина. All rights reserved.
//

import UIKit
import RealmSwift

class ProfileViewController: UIViewController,UpdateLabelTextDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    var currentUser:User!
    @IBOutlet weak var pic: UIImageView!
    @IBOutlet weak var NameLabel: UILabel!

    func updateLabelText(withText text: String) {
      NameLabel.text = text
    }
    
    

    
    @IBAction func LogOut(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: true)

    }
   
    @IBOutlet weak var profileSettings: UIView!
    @IBOutlet weak var reservations: UIView!
    let imagePicker = UIImagePickerController()
    
    
    @IBAction func SwitchProfile(_ sender: AnyObject) {
        switch sender.selectedSegmentIndex {
        case 0 :
            profileSettings.isHidden = false
            reservations.isHidden = true
        case 1:
            profileSettings.isHidden = true
            reservations.isHidden = false
        default: break;
    }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if let vc = segue.destination as? ProfileSettingsViewController,
                segue.identifier == "ProfSettings" {
                vc.delegate = self
            }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        profileSettings.isHidden = false
        reservations.isHidden = true
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        pic.isUserInteractionEnabled = true
        pic.addGestureRecognizer(tapGestureRecognizer)
        let realm = try! Realm()
        let id = UserDefaults.standard.string(forKey: "UserId")!
        currentUser = realm.objects(User.self).filter("id==  %@", id).first
        NameLabel.text=currentUser!.name
        imagePicker.delegate = self
        if (currentUser!.pic=="user" || currentUser!.pic=="default")
        {pic.image=UIImage(named: currentUser!.pic)}
        else {
            let directoryPath =  NSHomeDirectory().appending("/Documents/")
            pic.image=UIImage(contentsOfFile: directoryPath+currentUser!.pic)
            ImageViewRound()
        }
    
        // Do any additional setup after loading the view.
    }
    func ImageViewRound()
    { pic.layer.cornerRadius = pic.frame.size.width / 2
               pic.clipsToBounds = true
               pic.layer.borderWidth = 3
               pic.layer.borderColor = UIColor.white.cgColor}
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {

        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            pic.contentMode = .scaleAspectFit
            pic.image = pickedImage
            saveImageToDocumentDirectory(pickedImage)
            ImageViewRound()
        }
        
        dismiss(animated: true, completion: nil)
    }
  

  
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        let tappedImage = tapGestureRecognizer.view as! UIImageView
       
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
            
        present(imagePicker, animated: true, completion: nil)
        
    }
    func saveImageToDocumentDirectory(_ chosenImage: UIImage)  {
        let directoryPath =  NSHomeDirectory().appending("/Documents/")
        
        if !FileManager.default.fileExists(atPath: directoryPath) {
            do {
                try FileManager.default.createDirectory(at: NSURL.fileURL(withPath: directoryPath), withIntermediateDirectories: true, attributes: nil)
            } catch {
                print(error)
            }
        }



        let filename=currentUser.id+".jpg"
        let filepath = directoryPath.appending(filename)
        let url = NSURL.fileURL(withPath: filepath)
        do {
            try chosenImage.jpegData(compressionQuality: 1.0)?.write(to: url, options: .atomic)
            let realm = try! Realm()
            try! realm.write {
     
                currentUser!.setValue(filename, forKey: "pic")
}
            

        } catch {
            print(error)
            print("file cant not be save at path \(filepath), with error : \(error)");
            
        }
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

