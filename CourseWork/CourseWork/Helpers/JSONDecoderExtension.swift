//
//  JSONDecoderExtenstion.swift
//  CourseWork
//
//  Created by Damir Zaripov on 18/12/2018.
//  Copyright © 2018 Damir Zaripov. All rights reserved.
//

import UIKit
import Alamofire

extension JSONDecoder {
    
    func decodeResponse<T: Decodable>(from response: DataResponse<Data>) -> Result<T> {
        guard response.error == nil else {
            print(response.error!)
            return .failure(response.error!)
        }
        
        guard let responseData = response.data else {
            print("didn't get any data from API")
            return .failure(response.error!)
        }
        
        do {
            let item = try decode(T.self, from: responseData)
            return .success(item)
        } catch {
            print("error trying to decode response")
            print(error)
            return .failure(error)
        }
    }
}
