//
//  SignInViewController.swift
//  CourseWork
//
//  Created by Damir Zaripov on 04/12/2018.
//  Copyright © 2018 Damir Zaripov. All rights reserved.
//

import UIKit

class SignInViewController: UIViewController {
    
    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    let showTabBarControllerFromLoginSegue = "showTabBarControllerFromLogin"

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func onLoginButtonPressed(_ sender: Any) {
        if (checkFieldToNill()) {
            let alert = AlertFactory.shared.createAlert(title: "Некорректные данные", message: "Логин и пароль не могут быть пустыми")
            self.present(alert, animated: true
                , completion: nil)
            return
        }
        
        if let login = self.loginTextField.text?.trimmingCharacters(in: .whitespaces),
            let password = self.passwordTextField.text {
            NetworkManager.shared.doLogin(with: login, and: password, onSuccess: { (token) in
                RequestManager.instance.token = token
                RequestManager.instance.login = login
                self.performSegue(withIdentifier: self.showTabBarControllerFromLoginSegue, sender: self)
            }, onFailure: { (error) in
                let alert = AlertFactory.shared.createAlert(title: "Неверные данные", message: "Логин или пароль введены неправильно")
                self.present(alert, animated: true, completion: nil)
            }) { (problem) in
                let alert = AlertFactory.shared.createAlert(title: "Проблемы с подключением", message: "Проверьте интернет-соединение")
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    func checkFieldToNill() -> Bool {
        if (loginTextField.text == "") || (passwordTextField.text == "") {
            return true
        } else {
            return false
        }
    }
}
