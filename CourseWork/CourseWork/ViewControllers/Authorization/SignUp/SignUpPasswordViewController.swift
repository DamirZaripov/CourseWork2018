//
//  SignUpPasswordViewController.swift
//  CourseWork
//
//  Created by Damir Zaripov on 20/11/2018.
//  Copyright © 2018 Damir Zaripov. All rights reserved.
//

import UIKit

class SignUpPasswordViewController: UIViewController {
    
    @IBOutlet fileprivate weak var textField: UITextField!
    let showTabBarControllerSegue = "showTabBarController"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        DispatchQueue.main.async {
            self.textField.becomeFirstResponder()
        }
    }
    
    @IBAction func onNextButtonPressed(_ sender: Any) {
        if self.textField.text == "" {
            let alert = AlertFactory.shared.createAlert(title: "Некорректный пароль", message: "Пароль не может быть пустым")
            self.present(alert, animated: true, completion: nil)
            return
        }
        
        if let password = self.textField.text {
            guard let login = RequestManager.instance.login else { return }
            NetworkManager.shared.createNewUser(password: password, login: login, onSuccess: { (result) in

                self.performSegue(withIdentifier: self.showTabBarControllerSegue, sender: self)
            }) { (result) in
                let alert = AlertFactory.shared.createAlert(title: "Что-то пошло не так", message: "Появились трудности, попробуйте повторить действие")
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    
}
