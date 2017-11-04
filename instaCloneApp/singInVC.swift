//
//  singInVC.swift
//  instaCloneApp
//
//  Created by Murat Erhan on 19.09.2017.
//  Copyright © 2017 Murat Erhan. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseStorage
import FirebaseDatabase


class singInVC: UIViewController {

    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func singInClicked(_ sender: Any) {
        
        if emailText.text != "" && passwordText.text != "" {

            Auth.auth().signIn(withEmail: emailText.text!, password: passwordText.text!, completion: { (user, error) in
                if error != nil {
                    let alert = UIAlertController(title: "Hata", message: error?.localizedDescription, preferredStyle: UIAlertControllerStyle.alert)
                    let okBtn = UIAlertAction(title: "ok", style: UIAlertActionStyle.cancel, handler: nil)
                    alert.addAction(okBtn)
                    self.present(alert, animated: true, completion: nil)
                    
                }else{
                    
                    UserDefaults.standard.set(user?.email, forKey: "user")
                    UserDefaults.standard.synchronize()
                    
                    let delegate : AppDelegate = UIApplication.shared.delegate as! AppDelegate
                    
                    delegate.rememberLogin()
                    
                }
            })
            
            
           
        }else{
            
            let alert = UIAlertController(title: "Hata", message: "Kullanıcı Adı yada Şifre Boş Olamaz", preferredStyle: UIAlertControllerStyle.alert)
            let okBtn = UIAlertAction(title: "ok", style: UIAlertActionStyle.cancel, handler: nil)
            
            alert.addAction(okBtn)
            self.present(alert, animated: true, completion: nil)
            
            
        }
    
        
    
    }
    
    @IBAction func singUpClicked(_ sender: Any) {
        
        if emailText.text != "" && passwordText.text != "" {
            Auth.auth().createUser(withEmail: emailText.text!, password: passwordText.text!) { (user, error) in
                
                if error != nil {
                    let alert = UIAlertController(title: "Hata", message: error?.localizedDescription, preferredStyle: UIAlertControllerStyle.alert)
                    let okBtn = UIAlertAction(title: "ok", style: UIAlertActionStyle.cancel, handler: nil)
                    alert.addAction(okBtn)
                    self.present(alert, animated: true, completion: nil)
                    
                }else{
                    
                    UserDefaults.standard.set(user?.email, forKey: "user")
                    UserDefaults.standard.synchronize()
                    
                    let delegate : AppDelegate = UIApplication.shared.delegate as! AppDelegate
                    
                    delegate.rememberLogin()
                    
                }
            }
        }else{
            
            let alert = UIAlertController(title: "Hata", message: "Kullanıcı Adı yada Şifre Boş Olamaz", preferredStyle: UIAlertControllerStyle.alert)
            let okBtn = UIAlertAction(title: "ok", style: UIAlertActionStyle.cancel, handler: nil)
            
            alert.addAction(okBtn)
            self.present(alert, animated: true, completion: nil)
            
            
        }
    }
    
}
