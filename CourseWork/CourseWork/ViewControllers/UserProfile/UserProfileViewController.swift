//
//  UserProfileViewController.swift
//  CourseWork
//
//  Created by Damir Zaripov on 05/12/2018.
//  Copyright © 2018 Damir Zaripov. All rights reserved.
//

import UIKit

class UserProfileViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var nameLabel: UILabel!
    var spells: [Spell] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.registerNib()
        self.setName()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.loadSpells()
    }

    func registerNib() {
        let nib = UINib(nibName: "AvailableSkillTableViewCell", bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: "availableSpell")
    }
    
    func setName() {
        guard let name = RequestManager.instance.login else {
            return
        }
        self.nameLabel.text = "Пользователь: \(name)"
    }
    
    func loadSpells() {
        NetworkManager.shared.getSpells { [weak self] (spells) in
            self?.spells = spells
            
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }
    
    
    @IBAction func pressedButtonLogOut(_ sender: Any) {
        let alert = UIAlertController(title: "Выход из аккаунта", message: "Продолжить выход из аккаунта?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Отмена", style: .cancel, handler: { action in
            print("Отмена")
        }))
        alert.addAction(UIAlertAction(title: "Да", style: .default, handler: { action in
            print("Да")
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let pageNVC = storyboard.instantiateViewController(withIdentifier: "mainNVC") as! TransparentNavigationController
            
            guard (pageNVC.viewControllers.first as? ViewController) != nil else { return }
            self.present(pageNVC, animated: true, completion: nil)
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
}

extension UserProfileViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 105
    }
}

extension UserProfileViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if spells.count == 0 {
            let noDataLabel: UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: tableView.bounds.size.height))
            noDataLabel.text = "У вас еще не выбраны курсы, поэтому нет навыков. Пройдите на экран 'Выборы курсов' и выберите курсы, чтобы начать!"
            noDataLabel.textColor = UIColor.white
            noDataLabel.numberOfLines = 0
            noDataLabel.font = UIFont(name: "Open Sans", size: 15)
            noDataLabel.textAlignment = .center
            tableView.backgroundView = noDataLabel
            tableView.separatorStyle = .none
        } else {
            tableView.backgroundView?.isHidden = true
        }
        
        return spells.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "availableSpell", for: indexPath) as! AvailableSkillTableViewCell
        cell.config(with: spells[indexPath.row])
        return cell
    }

}
