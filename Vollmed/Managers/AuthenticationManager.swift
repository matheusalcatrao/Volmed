//
//  AuthenticationManager.swift
//  Vollmed
//
//  Created by Matheus Cepil Alcatrao on 13/03/24.
//

import Foundation


class AuthenticationManager: ObservableObject  {
    
    static let shared = AuthenticationManager()
    
    @Published var token: String?
    @Published var patientiID: String?
    
    private init() {
        self.token = KeychainHelper.get(for: "app-vollmed-token")
        self.patientiID = KeychainHelper.get(for: "app-vollmed-patient-id")
    }
    
    func saveToken(token: String) {
        KeychainHelper.save(value: token, key: "app-vollmed-token")
        DispatchQueue.main.async {
            self.token = token
        }
        
    }
    
    func removeToken() {
        KeychainHelper.remove(for: "app-vollmed-token")
        DispatchQueue.main.async {
            self.token = nil
        }
    }
    
    func savePatinetID(id: String) {
        KeychainHelper.save(value: id, key: "app-vollmed-patient-id")
        DispatchQueue.main.async {
            self.patientiID = id
        }
    }
    
    func removePatientID() {
        KeychainHelper.remove(for: "app-vollmed-patient-id")
        DispatchQueue.main.async {
            self.patientiID = nil
        }
    }
}
