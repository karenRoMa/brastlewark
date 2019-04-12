//
//  Router.swift
//  Brastlewark
//
//  Created by Karen Rodriguez on 4/8/19.
//  Copyright © 2019 Karen Rodriguez. All rights reserved.
//

import Foundation
import SwiftyJSON

/// Type defined to describe the requests parameters
typealias Parameters = [String: Any]

/**
 Router where all the available requests are defined and all their properties nedeed to perform the request to the server
 ````
 case singleChargeByAmount(Parameters)
 case singleChargeByCard(Parameters)
 case departmentStoreCharge(Parameters)
 case generateClient(Parameters)
 case associatePaymentToClient(Parameters)
 case getClientInformation(String)
 
 ````
 */
enum Router {
    
    /// Base URL in String format for the API
    static var baseURLString: String {
        guard let infoPlist = Bundle.main.infoDictionary else {return ""}
        return infoPlist["BaseURL"] as? String ?? ""
    }
    
    // MARK: - Single Charge -
    
    case getData
    
    // MARK: - Properties -
    
    var jsonDecoder: JSONDecoder {
        return JSONDecoder()
    }
    
    /// The method for the give request (It can be POST, GET, PUT or DELETE)
    var method: RequestMethod {
        switch self {
        case .getData:
            return .get
        }
    }
    
    /// The path for the given request (contains query parameters in case of exist given in each case)
    var path: String {
        switch self {
        case .getData:
            return "/rrafols/mobile_test/master/data.json"
        }
    }
    
    /*
     MARK: - URLRequest -
     
     Creates URLRequest with the given method and parameters to make the request.
     */
    
    private func asUrlRequest() -> URLRequest {
        let urlBase = URL(string: Router.baseURLString)!
        var request = URLRequest(url: urlBase.appendingPathComponent(path))
        
        request.httpMethod = method.value
        print(request)
        return request
    }
    
    
    /// Parse the parameters to a valid format to make the request
    private func createBody(parameters: [String : Any]) -> Data? {
        let json: Data
        do {
            json = try JSONSerialization.data(withJSONObject: parameters, options: [])
        } catch {
            print("Error: cannot create JSON parameter")
            return nil
        }
        return json
    }
    
    func performRequest(completionBlock: @escaping (JSON?) -> ()) {
        let task = URLSession.shared.dataTask(with: self.asUrlRequest()) { (data, response, error) in
            if error != nil {
                DispatchQueue.main.async {
                    HandlerError.shared.handle(withError: ErrorType(responseError: nil, serverError: error!), delegate: nil)
                    completionBlock(nil)
                }
                return
            }

            if let data = data {
                DispatchQueue.main.async {
                    let jsonResponse = JSON(data)
                    completionBlock(jsonResponse)
                }
            } else {
                let json = try? JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? [String:Any]
                if json != nil {
                    HandlerError.shared.handle(withError: ErrorType(responseError: json!!))
                }
                completionBlock(nil)
            }
        }
        task.resume()
    }
    
}
