//
//  Date+.swift
//  Vollmed
//
//  Created by Matheus Cepil Alcatrao on 07/02/24.
//

import Foundation

extension Date {
    func convertToString() -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        
        let dateString = dateFormatter.string(from: self)
        return dateString
    }
}
