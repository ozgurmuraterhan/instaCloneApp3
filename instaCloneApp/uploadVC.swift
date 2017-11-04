//
//  uploadVC.swift
//  instaCloneApp
//
//  Created by Murat Erhan on 19.09.2017.
//  Copyright © 2017 Murat Erhan. All rights reserved.
//

import UIKit
import Firebase
import FirebaseStorage
import FirebaseAuth
import FirebaseDatabase

class uploadVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var postComment: UITextField!
    @IBOutlet weak var postImage: UIImageView!
    
    var uuid = NSUUID().uuidString
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        postImage.isUserInteractionEnabled = true
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(uploadVC.choosePhoto))
        postImage.addGestureRecognizer(recognizer)
        
    }


    @IBAction func postButtonClicked(_ sender: Any) {
        
        let mediaFolder = Storage.storage().reference().child("media")
        
        if let data = UIImageJPEGRepresentation(postImage.image!, 0.50){
        
            mediaFolder.child("\(uuid).jpg").putData(data, metadata: nil, completion: { (metadata, error) in
                
                if error != nil{
                    
                    let alert = UIAlertController(title: "Error", message: error.debugDescription, preferredStyle: UIAlertControllerStyle.alert)
                    let okBtn = UIAlertAction(title: "ok", style: UIAlertActionStyle.cancel, handler: nil)
                    
                    alert.addAction(okBtn)
                    
                    self.present(alert, animated: true, completion: nil)
                    
                    
                }else{
                    
                    let imgUrl = metadata?.downloadURL()?.absoluteString
                    
                    let post = ["image" : imgUrl!, "postedby" : Auth.auth().currentUser!.email!, "posttext" : self.postComment.text!, "uuid" : self.uuid] as [String : Any]
                    Database.database().reference().child("users").child((Auth.auth().currentUser?.uid)!).child("post").childByAutoId().setValue(post)
                    
                    self.postImage.image = UIImage(named : "selectImage.jpg")
                    self.postComment.text = ""
                    self.tabBarController?.selectedIndex = 0
                }
                
            })
        }
        
    }
    
    @objc func choosePhoto(){
        
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        picker.allowsEditing = true
        present(picker, animated: true, completion: nil)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        postImage.image = info[UIImagePickerControllerEditedImage] as? UIImage
        self.dismiss(animated: true, completion: nil)
    }
    
}
