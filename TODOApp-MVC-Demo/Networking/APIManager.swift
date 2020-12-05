//
//  APIManager.swift
//  TODOApp-MVC-Demo
//
//  Created by Hossam on 10/28/20.
//  Copyright © 2020 IOS. All rights reserved.
//

import Foundation
import Alamofire
import SDWebImage

class APIManager {
    //MARK:- Register
    class func  register(body: userRegister ,completion: @escaping (Result<TasksResponse, Error>)-> ()){
        request(APIRouter.register(_body: body)){ (response) in completion(response)
        }
    }
    //MARK:- Login
    class func  login(email: String, password: String, completion: @escaping (Result<LoginResponse, Error>)-> ()){
        request(APIRouter.login(email, password)){ (response) in
            completion(response)
        }
    }
    //MARK:- Add Task
    class func addTask(description: String, completion: @escaping (Result<TaskData,Error>) -> Void){
        request(APIRouter.addTodos(description)) { (response) in
            completion(response)
            
        }
    }
    
    //MARK:- Get TODOS
    class func getTodos(completion: @escaping (Result<TasksResponse?, Error>)-> ()){
        request(APIRouter.getTodos){ (response) in
            completion(response)
        }
    }
    
    //MARK:- Get User Data
    
    class func getUserData(completion: @escaping (Result<UserData, Error>)-> ()){
        request(APIRouter.getUserData){ (response) in
            completion(response)
        }
    }

    //MARK:- Log Out

    class func LogOut(completion: @escaping (Result<UserData, Error>)-> ()){
        request(APIRouter.logOut){ (response) in
            completion(response)
        }
    }
    
    //MARK:- Delete Task
    class func deleteTask(completion: @escaping (Result<TasksResponse,Error>) -> Void){
        request(APIRouter.deleteTask) { (response) in
            completion(response)
            
        }
    }
    
    //MARK:- Update Task
    class func updateData(age: Int , completion: @escaping (Result<UserData,Error>) -> Void){
        request(APIRouter.update(age)) { (response) in
            completion(response)
            
        }
    }
    
    class func uploadUserImage(userImage: UIImage ,completion: @escaping (_ error: Error?) -> Void) {
        
        let userToken = UserDefaultsManager.shared().token
        let headers: HTTPHeaders = [HeaderKeys.Authorization: "Bearer \(userToken ?? "")"]
        
        AF.upload(multipartFormData: { (form) in
            
            if let data = CodableImage.setImage(image: userImage){
                form.append(data, withName: "avatar",fileName: "/home/ali/Mine/c/nodejs-blog/public/img/blog-header.jpg" , mimeType: "blog-header.jpg")
            }
        },to: URLs.uploadImage,
            method: HTTPMethod.post,
            headers: headers).response{ response in
                guard response.error == nil else{
                    print(response.error!.localizedDescription)
                    completion(response.error)
                    return
                }
                print(response)
                completion(nil)
        }
    }
    
    class func getUserImageAPIRouter(completion: @escaping (_ image: UIImage?,_ error: Error?) -> Void){
        requestBool(APIRouter.getImage) { (image,error)  in
            completion(image,error)
        }
    }
}


extension APIManager{
   
    private static func request<T: Decodable>(_ urlConvertible: URLRequestConvertible, completion:  @escaping (Result<T, Error>) -> ()) {
        AF.request(urlConvertible).responseDecodable { (response: AFDataResponse<T>) in
            switch response.result {
            case .success(let value):
                completion(.success(value))
            case .failure(let error):
                completion(.failure(error))
            }
            }
            .responseJSON { response in
                print(response)
        }
    }
    
    private static func requestBool(_ urlConvertible: URLRequestConvertible, completion:  @escaping (_ image: UIImage?,_ error: Error?) -> ()) {
        // Trigger the HttpRequest using AlamoFire
        AF.request(urlConvertible).response { (response) in
            guard response.error == nil else{
                completion(nil,response.error)
                return
            }
            
            guard let data = response.data else{
                print("didn't get any data from API")
                return
            }
            
            let image = UIImage(data: data)
            completion(image,nil)
            
        }
    }
    
}





