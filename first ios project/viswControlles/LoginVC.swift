//
//  LoginVC.swift
//  first ios project
//
//  Created by IOS on 7/27/20.
//  Copyright © 2020 IOS. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {
    
    // MARK: - outlet
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    //variables
    var user : User!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //title
       self.navigationItem.title = "Login"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
         user = getUserDefaults()
        //print(user.email)
        UserDefaults.standard.set(false, forKey: "isLoggedIn")
    }
    
    // MARK: - login
    @IBAction func loginBtnTapped(_ sender: UIButton) {
        if (emailCheck(user : user) && passwordeCheck(user : user)) {
            let profileVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ProfileVC") as! ProfileVC
            navigationController?.pushViewController(profileVC, animated: true)
        }
    }
    
    // MARK: - email
    func emailCheck(user : User) -> Bool {
        guard let email = emailTextField.text , email.count > 0 , emailTextField.text == user.email
        else {
            let alert = UIAlertController(title: "ERROR", message: "Enter valid email", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
            return false
        }
        return true
    }
    
    // MARK: - password
    func passwordeCheck(user : User) -> Bool {
        guard let password = passwordTextField.text , password.count > 0 , passwordTextField.text == user.password
            else {
                let alert = UIAlertController(title: "ERROR", message: "Password not correct", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                
                return false
        }
        return true
    }

    //recieve user data
    func getUserDefaults() -> User? {
        if let savedUser =  UserDefaults.standard.object(forKey: "user") as? Data {
            let decoder = JSONDecoder()
            if let loadedUser = try? decoder.decode(User.self, from: savedUser) {
                return loadedUser
            }
        }
        return nil
    }
}
