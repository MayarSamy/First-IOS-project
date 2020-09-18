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
    var user: User = User()

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //title
        self.navigationItem.title = "Profile"
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let email = UserDefaultManager.shared().email
        user = SQLManager.shared().retriveUserData(userMail: email)
        //userImage.image = user.image.getImage()
        let image = CodableImage.getImage(imageData: user.image)
        userImage.image = image
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
}
