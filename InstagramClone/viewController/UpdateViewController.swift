//
//  UpdateViewController.swift
//  InstagramClone
//
//  Created by Bekir Geriş on 28.09.2023.
//

import UIKit
import FirebaseCore
import FirebaseStorage
import FirebaseFirestore
import FirebaseAuth

class UpdateViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var descriptionText: UITextField!
    @IBOutlet weak var uploadButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        imageView.isUserInteractionEnabled = true
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(chooseImage))
        imageView.addGestureRecognizer(gestureRecognizer)
    }
    
    @objc func chooseImage() {
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.sourceType = .photoLibrary
        present(pickerController, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imageView.image = info[.originalImage] as? UIImage
        self.dismiss(animated: true)
        uploadButton.isEnabled = true
    }

    @IBAction func uploadClick(_ sender: Any) {
        let storage = Storage.storage()
        let storageReferance = storage.reference()
        
        let mediaFolder = storageReferance.child("media")
        
        if let data = imageView.image?.jpegData(compressionQuality: 0.5) {
            
            let uuid = UUID().uuidString
            
            let imageReferance = mediaFolder.child("\(uuid).jpeg")
            
            imageReferance.putData(data) { metdaData, error in
                if error != nil {
                    self.makeAlert(title: "Error!", message: error?.localizedDescription ?? "error")
                } else {
                    imageReferance.downloadURL { url, error in
                        if error == nil {
                            let imageUrl = url?.absoluteString
                            
                            let firestorePost = [
                                "imageUrl" : imageUrl!,
                                "postedBy" : Auth.auth().currentUser!.email!,
                                "comment" : self.descriptionText.text!,
                                "date" : FieldValue.serverTimestamp()
                            ] as [String : Any]
                            
                            let firestoreDatabase = Firestore.firestore()
                            firestoreDatabase
                                .collection("Posts")
                                .addDocument(data: firestorePost) { error in
                                if error != nil {
                                    self.makeAlert(title: "Error!", message: error?.localizedDescription ?? "error")
                                } else {
                                    self.imageView.image = UIImage(systemName: "photo")
                                    self.descriptionText.text = ""
                                    self.tabBarController?.selectedIndex = 0
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    
    func makeAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default)
        alert.addAction(okButton)
        self.present(alert, animated: true)
    }
}
