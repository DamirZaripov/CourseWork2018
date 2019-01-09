//
//  NetworkManager.swift
//  CourseWork
//
//  Created by Damir Zaripov on 03/12/2018.
//  Copyright © 2018 Damir Zaripov. All rights reserved.
//

import Alamofire
import UIKit

class NetworkManager {
    
    static let shared = NetworkManager()
    
    init() {}
    
    func changeToDoValue(id: Int, oldValue: Bool, complitionBlock: @escaping (Bool) -> ()) {
        
        guard let token = RequestManager.instance.token else { return }
        
        let url = "http://31.148.219.177/api/student_api/todos/\(id)"
        
        var selectedValue: String
        
        if (oldValue) {
            selectedValue = "false"
        } else {
            selectedValue = "true"
        }
        
        let parameters = [
            "selected": selectedValue
        ]
        
        let headers = [
            "Content-Type": "application/x-www-form-urlencoded",
            "my_token": token
        ]
        
        Alamofire.request(url, method: .put, parameters: parameters, headers: headers).responseData { (response) in
            
            guard let statusCode = response.response?.statusCode else { return }
            
            switch statusCode {
            case 200:
                complitionBlock(true)
            case 404:
                complitionBlock(false)
            default:
                break
            }
        }
    }
    
    func cancelCourse(id: Int, complitionBlock: @escaping (Bool) -> ()) {
        
        guard let token = RequestManager.instance.token else { return }
        
        let url = "http://31.148.219.177/api/student_api/courses/\(id)"
        
        let parameters = [
            "selected": "false"
        ]
        
        let headers = [
            "Content-Type": "application/x-www-form-urlencoded",
            "my_token": token
        ]
        
        Alamofire.request(url, method: .put, parameters: parameters, headers: headers).responseData { (response) in
            
            guard let statusCode = response.response?.statusCode else { return }
            
            switch statusCode {
            case 200:
                complitionBlock(true)
            case 404:
                complitionBlock(false)
            default:
                break
            }
        }
        
    }
    
    func chooseCourse(id: Int, complitionBlock: @escaping (Bool) -> ()) {
        
        guard let token = RequestManager.instance.token else { return }
        
        let url = "http://31.148.219.177/api/student_api/courses/\(id)"
    
        let parameters = [
            "selected": "true"
        ]
        
        let headers = [
            "Content-Type": "application/x-www-form-urlencoded",
            "my_token": token
        ]
        
        Alamofire.request(url, method: .put, parameters: parameters, headers: headers).responseData { (response) in
            
            guard let statusCode = response.response?.statusCode else { return }
 
            switch statusCode {
            case 200:
                complitionBlock(true)
            case 404:
                complitionBlock(false)
            default:
                break
            }
        }
    }
    
    func getBlocks(complitionBlock: @escaping ([Block]) -> ()) {
        
        let url = "http://31.148.219.177/api/blocks"
        
        guard let token = RequestManager.instance.token else {
            return
        }
        
        let headers = [
            "Accept": "application/json",
            "my_token": token
        ]
        
        Alamofire.request(url, method: .get, headers: headers).responseData { (response) in
            if response.result.isSuccess {
                let decoder = JSONDecoder()
                let result: Result<[Block]> =  decoder.decodeResponse(from: response)
                switch result {
                case .success(let blocks):
                    complitionBlock(blocks)
                    
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    func getSpells(complitionBlock: @escaping ([Spell]) -> ()) {
        
        let url = "http://31.148.219.177/api/student_api/my_learning_spells"
        
        guard let token = RequestManager.instance.token else {
            return
        }
        
        let headers = [
            "Accept": "application/json",
            "my_token": token
        ]
        
        Alamofire.request(url, method: .get, headers: headers).responseData { (response) in
            if response.result.isSuccess {
                let decoder = JSONDecoder()
                let result: Result<[Spell]> =  decoder.decodeResponse(from: response)
                switch result {
                case .success(let spells):
                    complitionBlock(spells)
                    
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    func doLogin(with login: String, and password: String, onSuccess: @escaping (_ result: String) -> (), onFailure: @escaping (_ result: String) -> (), problemWithInternetConnection: @escaping (_ result: String) -> ()) {
        let url = "http://31.148.219.177/api/login"
        
        let user = [
            "login" : login,
            "password" : password
        ]
        
        Alamofire.request(url, method: .post, parameters: user).response { (response) in
            let statusCode = response.response?.statusCode
            
            switch statusCode {
            case 200:
                
                guard let data = response.data else {
                    return
                }
                
                guard let responseJSONData = try? JSONSerialization.jsonObject(with: data, options: []) else {
                    return
                }
                
                guard let responseJSON = responseJSONData as? [String: Any] else {
                    return
                }
                
                let token = responseJSON["token"] as! String
                onSuccess(token)
                
            case 400:
                
                guard let data = response.data else {
                    return
                }
                
                guard let responseJSONData = try? JSONSerialization.jsonObject(with: data, options: []) else {
                    return
                }
                
                guard let responseJSON = responseJSONData as? [String: Any] else {
                    return
                }
                
                let error = responseJSON["code"] as! String
                onFailure(error)
                
            case nil:
                problemWithInternetConnection("Проблемы с интернетом. Проверьте подключение")
                
            default: fatalError()
            }
        }
    }
    
    func isLoginAlreadyUseRequest(with login: String, complitionBlock: @escaping (_ result: Bool) -> (), problemWithInternetConnection: @escaping (_ result: String) -> ()) {
        let url = "http://31.148.219.177/api/user_by_login/\(login)"
        
        Alamofire.request(url, method: .head).responseString { (response) in
            let statusCode = response.response?.statusCode
            
            switch statusCode {
            case 200: complitionBlock(true)
                
            case 404: complitionBlock(false)
           
            case nil:
                problemWithInternetConnection("Проблемы с интернетом. Проверьте подключение")
                
            default: fatalError()
            }
        }
    }
    
    func createNewUser(password: String, login: String, onSuccess: @escaping (_ result: Bool) -> (), onFailure: @escaping (_ result: Bool) -> ()) {
        
        let url = "http://31.148.219.177/api/register"

        let user = [
            "login" : login,
            "password" : password
        ]
        
        Alamofire.request(url, method: .post, parameters: user).response { (response) in
            let statusCode = response.response?.statusCode
            
            switch statusCode {
            case 200:
                
                guard let data = response.data else {
                    return
                }
                
                guard let responseJSONData = try? JSONSerialization.jsonObject(with: data, options: []) else {
                    return
                }
                
                guard let responseJSON = responseJSONData as? [String: Any] else {
                    return
                }
                
                let token = responseJSON["token"] as! String
                RequestManager.instance.token = token
                
                onSuccess(true)
                
            case 400: onFailure(false)
                
            default: fatalError()
            }
        }
    }
}
