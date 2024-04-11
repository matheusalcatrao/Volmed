//
//  String+.swift
//  Vollmed
//
//  Created by Matheus Cepil Alcatrao on 07/02/24.
//

import Foundation

extension String {
    func converDateStringToReadableDate() ->  String {
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        
        if let date = inputFormatter.date(from: self) {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd/MM/yyyy 'às' HH:mm"
            return dateFormatter.string(from: date)
        }
        
        return ""
    }
}
