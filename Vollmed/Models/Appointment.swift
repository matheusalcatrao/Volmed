//
//  Appointment.swift
//  Vollmed
//
//  Created by Matheus Cepil Alcatrao on 08/02/24.
//

import Foundation

struct Appointment: Codable, Identifiable {
    let id, date: String
    let specialist: Specialist
    
    enum CodingKeys : String, CodingKey {
        case id
        case date = "data"
        case specialist = "especialista"
    }
}

