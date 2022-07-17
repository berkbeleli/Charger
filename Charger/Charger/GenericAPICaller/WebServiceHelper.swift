//
//  WebServiceHelper.swift
//  Charger
//
//  Created by Berk Beleli on 2022-07-12.
//

import Foundation
import Alamofire


class WebServiceHelper {
  static let instance = WebServiceHelper() // create singleton object
  let connectivityManager = NetworkReachabilityManager()
  let manager = Alamofire.Session()
  
  // With this generic function we can handle all of our app api call with just one function
  func getServiceData <T: Codable> (url: String, method: HTTPMethod, parameters: [String:Any]? = nil, header: HTTPHeaders? = nil, logout: Bool? = false ,completion: @escaping (T?, String?) ->()) {
        
        if connectivityManager?.isReachable ?? false { // check network availability
            let manager = Alamofire.Session.default
            manager.session.configuration.timeoutIntervalForRequest = 20 // set a timeout for our session

            manager.request(url, method: method, parameters: parameters, encoding: JSONEncoding.prettyPrinted,  headers: header).responseJSON { (response) in // request according to our chooses
                
              if response.response?.statusCode == 200 { // if response code equal to 200 handle the response value
                if method == .delete { // if received request type is delete directly complete the func do not try to decode as response is empty
                  completion("Deleted Appointment" as! T, nil)
                }else if logout ?? false { // if received request is logout directly complete the func do not try to decode as response is empty
                  completion("LOGGED OUT" as! T, nil)
                }else {
                  guard let data = response.data else {return completion(nil, response.error?.localizedDescription)} // check error
                  do{
                      let returnedResponse = try JSONDecoder().decode(T.self, from: data) // decode according to given object type
                      completion(returnedResponse, nil) // return decoded object
                  }catch{
                      completion(nil, error.localizedDescription)
                  }
                }
                
              }else if response.error != nil{
                completion(nil, response.error?.localizedDescription)
              }else {
                switch response.result {
                case .success(let result):
                  if let res  = result as? [String: AnyObject] {
                    completion(nil, (res["message"] as! String ?? "UNKNOWN ERROR") ) // if server returns any error receive it like "EMAILNOTINCORRECTFORM"
                  }
                case .failure(let result):
                  completion(nil, "UNKNOWN ERROR" ) // If the error is not known error
                }
              }
            }
        }
        else {
            completion(nil, "Network Not Reachable") // if there is no internet connectivity
        }
    }
}

