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
    var user: User = User()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //title
       self.navigationItem.title = "Login"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true
        
       let email = UserDefaultManager.shared().email
        user = SQLManager.shared().retriveUserData(userMail: email)
        
       UserDefaultManager.shared().isLoggedIn = false
    }
    
    // MARK: - login
    @IBAction func loginBtnTapped(_ sender: UIButton) {
            if (emailCheck(user : user) && passwordeCheck(user : user)) {
                let MainVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MediaFinderVC") as! MediaFinderVC
                navigationController?.pushViewController(MainVC, animated: true)
        }
    }
    
    @IBAction func createAccountBtnTapped(_ sender: Any) {
        let SignUpVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SignUpVC") as! SignUpVC
        navigationController?.pushViewController(SignUpVC, animated: true)
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
//
//    // MARK: - password
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
}
