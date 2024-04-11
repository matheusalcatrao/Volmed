//
//  RequestError.swift
//  Vollmed
//
//  Created by Matheus Cepil Alcatrao on 21/03/24.
//

import Foundation

enum RequestError: Error {
    case decode
    case invalidURL
    case noResponse
    case unauthorized
    case unknown
    case custom(_ error: [String: Any])
    
    var customMessage: String {
        switch self {
        case .decode:
            return "erro de decodificação"
        case .unauthorized:
            return "erro de autenticação"
        default:
            return "erro desconhecido"
        }
    }
}
