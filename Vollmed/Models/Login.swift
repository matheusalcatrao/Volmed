//
//  Login.swift
//  Vollmed
//
//  Created by Matheus Cepil Alcatrao on 11/03/24.
//

import Foundation

struct LoginRequest: Codable {
    let email: String
    let password: String
    
    enum CodingKeys: String, CodingKey {
        case email
        case password = "senha"
    }
}


struct LoginResponse: Codable {
    let auth: Bool
    let rota: String
    let token: String
    let id: String
}
