//
//  ProfileVC.swift
//  first ios project
//
//  Created by IOS on 7/27/20.
//  Copyright © 2020 IOS. All rights reserved.
//

import UIKit

class ProfileVC: UIViewController {
    
    // MARK: - outlet
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var emailLbl: UILabel!
    @IBOutlet weak var phoneLbl: UILabel!
    @IBOutlet weak var addressLbl: UILabel!
    @IBOutlet weak var genderLbl: UILabel!
    @IBOutlet weak var userImage: UIImageView!
    
    //variables
    var user : User!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Hide the Navigation Bar
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
        //title
        self.navigationItem.title = "Profile"
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        UserDefaultManager.shared().isLoggedIn = true
         //UserDefaults.standard.set(true, forKey: "isLoggedIn")
        
        
       // user = getUserDefaults()
       user = UserDefaultManager.shared().user
        
        userImage.image = user.image.getImage()
        nameLbl.text = user.name
        emailLbl.text = user.email
        phoneLbl.text = user.phone
        addressLbl.text = user.address
        genderLbl.text = user.gender.rawValue

    }
    
    // MARK: - logout
    @IBAction func logoutBtnTapped(_ sender: UIButton) {
        let loginVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LoginVC")
        navigationController?.pushViewController(loginVC, animated: true)
    }
    
//    func getUserDefaults() -> User? {
//        if let savedUser =  UserDefaults.standard.object(forKey: "user") as? Data {
//            let decoder = JSONDecoder()
//            if let loadedUser = try? decoder.decode(User.self, from: savedUser) {
//                return loadedUser
//            }
//        }
//        return nil
//    }
}
