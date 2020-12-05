//
//  APIRouter.swift
//  TODOApp-MVC-Demo
//
//  Created by Hossam on 11/8/20.
//  Copyright © 2020 IOS. All rights reserved.
//

import Foundation
import Alamofire


enum APIRouter: URLRequestConvertible{
    
    // The endpoint name
    case register(_body: userRegister)
    case login(_ email: String, _ password: String)
    case addTodos(_ description: String)
    case getTodos
    case getUserData
    case logOut
    case update(_ age: Int)
    case deleteTask
    case uploadImage
    case getImage
    
    
    // MARK: - HttpMethod
    private var method: HTTPMethod {
        switch self{
        case .getTodos, .getUserData , .logOut , .getImage:
            return .get
        case .login , .register , .addTodos , .uploadImage:
            return .post
        case .update:
            return .put
        case .deleteTask:
            return .delete
        default:
            break
        }
    }
    
    // MARK: - Parameters
    private var parameters: Parameters? {
        switch self {
        case .login(let email, let password):
            return [ParameterKeys.email: email, ParameterKeys.password: password]
        case .register(let body):
            return [ParameterKeys.name: body.name , ParameterKeys.email: body.email, ParameterKeys.age: body.age , ParameterKeys.password: body.password]
        case .addTodos(let description):
            return [ParameterKeys.description: description]
        case .update(let age):
            return [ParameterKeys.age: age ]
        default:
            return nil
        }
    }
    
    // MARK: - Path
    private var path: String {
        switch self {
        case .login:
            return URLs.login
        case .register:
            return URLs.register
        case .addTodos , .getTodos:
            return URLs.todos
        case .getUserData:
            return URLs.userData
        case .logOut:
            return URLs.logout
        case .update:
            return URLs.userData
        case .deleteTask:
            return URLs.todos + "/\(UserDefaultsManager.shared().taskId ?? "")"
        case .uploadImage:
            return URLs.uploadUserImage
        case .getImage:
            return  "/user/\(UserDefaultsManager.shared().userId ?? "")/avatar"
            
        }
    }
    
    // MARK: - URLRequestConvertible
    func asURLRequest() throws -> URLRequest {
        let url = try URLs.base.asURL()
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        //httpMethod
        urlRequest.httpMethod = method.rawValue
        switch self {
        case .addTodos , .getTodos , .update , .deleteTask, .getUserData, .logOut, .uploadImage :
            urlRequest.setValue("Bearer \(UserDefaultsManager.shared().token ?? "")",
                forHTTPHeaderField: HeaderKeys.Authorization)
            urlRequest.setValue("application/json", forHTTPHeaderField: HeaderKeys.contentType)
        default:
            break
        }
        
       urlRequest.setValue("application/json", forHTTPHeaderField: HeaderKeys.contentType)
        
        
        // HTTP Body
        let httpBody: Data? = {
            switch self {
            case .register(let body):
                return encodeToJSON(body)
            default:
                return nil
            }
        }()
        urlRequest.httpBody = httpBody
        
        // Encoding
        let encoding: ParameterEncoding = {
            switch method {
            case .get, .delete:
                return URLEncoding.default
            default:
                return JSONEncoding.default
            }
        }()
        print(try encoding.encode(urlRequest, with: parameters))
        return try encoding.encode(urlRequest, with: parameters)
    }
}

extension APIRouter {
    private func encodeToJSON<T: Encodable>(_ body: T) -> Data? {
        do {
            let anyEncodable = AnyEncodable(body)
            let jsonData = try JSONEncoder().encode(anyEncodable)
            let jsonString = String(data: jsonData, encoding: .utf8)!
            print(jsonString)
            return jsonData
        } catch {
            print(error)
            return nil
        }
    }
}

// type-erasing wrapper
struct AnyEncodable: Encodable {
    private let _encode: (Encoder) throws -> Void
    
    public init<T: Encodable>(_ wrapped: T) {
        _encode = wrapped.encode
    }
    
    func encode(to encoder: Encoder) throws {
        try _encode(encoder)
    }
}
