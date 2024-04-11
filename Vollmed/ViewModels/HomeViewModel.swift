//
//  HomeViewModel.swift
//  Vollmed
//
//  Created by Matheus Cepil Alcatrao on 13/03/24.
//

import Foundation


struct HomeViewModel {
    let service: HomeServiceable
    var authManager = AuthenticationManager.shared
    
    init(service: HomeServiceable) {
        self.service = service
    }
    
    func getSpecialist() async throws -> [Specialist]? {
        let result = try await service.getAllSpecialists()
        
        switch result {
        case .success(let response):
            return response
        case .failure(let error):
            throw error
        }
    }
    
    func logout() {
        authManager.removeToken()
    }
}
