//
//  feedVC.swift
//  instaCloneApp
//
//  Created by Murat Erhan on 19.09.2017.
//  Copyright © 2017 Murat Erhan. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase
import SDWebImage



class feedVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    var useremailArray = [String]()
    var postCommentArray = [String]()
    var postImageUrlArray = [String]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        getDataFormServer()
        

        // Do any additional setup after loading the view.
    }
    
    func getDataFormServer(){
        
        Database.database().reference().child("users").observe(DataEventType.childAdded) { (snapShot) in
           
            let values = snapShot.value! as! NSDictionary
            let post = values["post"] as! NSDictionary
            let postIDs = post.allKeys
            
            
            for id in postIDs{
                let singlePost = post[id] as! NSDictionary
                
                self.useremailArray.append(singlePost["postedby"] as! String)
                self.postCommentArray.append(singlePost["posttext"] as! String)
                self.postImageUrlArray.append(singlePost["image"] as! String)
                
                
            }
            self.tableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return useremailArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! feedCell
        
        cell.commentLabel.text = postCommentArray[indexPath.row]
        cell.emailLabel.text = useremailArray[indexPath.row]
        
        
        
        cell.imagesView.sd_setImage(with: URL(string: self.postImageUrlArray[indexPath.row]))
        return cell
    }
    
    
    
    @IBAction func logoutClicked(_ sender: Any) {
        
        // sessionları siliyoruz.
        UserDefaults.standard.removeObject(forKey: "user")
        UserDefaults.standard.synchronize()
        
        //singInVC'u tanımlıyoruz, çıkış yapılınca buraya gidecek.
        let singIn = self.storyboard?.instantiateViewController(withIdentifier: "singInVC") as! singInVC
        
        // appDelegate dosyasını tanımlıyoruz, bu dosya içerisinden rememberLogin fonksiyonunu çalıştıracağız
        let delegate : AppDelegate = UIApplication.shared.delegate as! AppDelegate
        //çıkış yapılınca yönlendirmeyi yapıyoruz
        delegate.window?.rootViewController = singIn
        //ve appdelegate dosyasından rememberLogin fonksiyonunu çalıştırıyoruz
        delegate.rememberLogin()
        
    }
    
  
}
