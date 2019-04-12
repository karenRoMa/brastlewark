//
//  ErrorType.swift
//  BaseProject
//
//  Created by Karen Rodriguez on 3/13/19.
//  Copyright © 2019 Karen Rodriguez. All rights reserved.
//

import Foundation

/// Class to handle errors received from the server
struct ErrorType: Error {

    enum ErrorKind {
        /// Unable to connect with the server
        case noConnection
        /// Unknown error
        case unknown
        /// Unauthorized employee
        case unauthorizedUser
        /// Object not found
        case notFound
        /// Username or password invalid
        case invalidUserOrPassword
        /// Invalid password
        case invalidPassword
        /// Inactive user
        case inactiveUser
        /// Conflict in the server DB
        case conflict
        /// Error when sending the email to confirm a register
        case sendEmailError
        
        // MARK: - Conekta -
        
        case invalidCard
        case cardDeclined
        case invalidExpiryMonth
        case invalidExpiryYear
        case invalidCVC
    }
    
    /// Error code that returns the server in the http body
    var errorCode: Int
    /// Title of the error that returns the server in the http body
    var detailedInfoTitle: String
    /// Detailed information that returns the server in the http body
    var detailedInfo: String
    /// Error kind
    var kind: ErrorKind = .unknown
    
    /// Initialize an instance of AKError based on a JSON error response from
    /// the API and an error kind from the ErrorKind enum of this type
    /// - parameter Error object received from server
    /// - parameter kind: The kind of the error, as defined in the ErrorKind enum
    init(responseError: [String: Any]? = nil, serverError: Error? = nil) {
        self.detailedInfoTitle = "Ups! Ocurrió un Error 🤭"
        if responseError == nil {
            if serverError != nil {
                self.errorCode = serverError!._code
                self.detailedInfo = "El error es desconocido. Detalles: \(serverError!.localizedDescription)"
            } else {
                self.errorCode = 0
                self.detailedInfo = "Lo sentimos, ocurrió un desconocido. Puedes contactar a soporte y explicar tu caso 😙"
            }
            self.kind = self.getKind(of: self.errorCode)
            return
        }

        self.errorCode = (responseError!["code"] as? Int) ?? 0
        self.detailedInfo = responseError!["es_message"] as? String ?? "Lo sentimos, ocurrió un desconocido. Puedes contactar a soporte y explicar tu caso 😙"
        if isConektaError(response: responseError!) { return }
        self.kind = getKind(of: self.errorCode)
    }
    
    func getKind(of code: Int) -> ErrorKind {
        switch code {
        case 422:
            return .unauthorizedUser
        case 404:
            return .notFound
        default:
            return .unknown
        }
    }
    
    mutating func isConektaError(response: [String: Any]) -> Bool {
        guard let codeString = response["code"] as? String else {return false}
        
        switch codeString {
        case "invalid_number":
            self.kind = .invalidCard
            self.detailedInfo = "Tarjeta inválida, intenta con otra o contacta a tu Banco 🤭 "
        case "card_declined":
            self.kind = .cardDeclined
            self.detailedInfo = "Tarjeta declinada, intenta con otra o contacta a tu Banco 🤭 "
        case "invalid_expiry_month":
            self.kind = .invalidExpiryMonth
            self.detailedInfo = "Mes de expiración inválido. Revisa que los datos ingresados sean correctos."
        case "invalid_expiry_year":
            self.kind = .invalidExpiryYear
            self.detailedInfo = "Año de expiración inválido. Revisa que los datos ingresados sean correctos."
        case "invalid_cvc":
            self.kind = .invalidCVC
            self.detailedInfo = "CVC inválido. Revisa que los datos ingresados sean correctos."
        default:
            self.kind = .unknown
            self.detailedInfo = "Lo sentimos, ocurrió un desconocido con Conekta. Puedes contactar a soporte y explicar tu caso 😙"
        }
        return true
    }
}
