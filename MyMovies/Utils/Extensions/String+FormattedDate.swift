//
//  String+FormattedData.swift
//  MyMovies
//
//  Created by Mateus Dias on 02/12/24.
//

import Foundation

extension String {
    func formattedYear(from dateString: String) -> String {
          let inputFormatter = DateFormatter()
          inputFormatter.dateFormat = "yyyy-MM-dd"
          
          guard let date = inputFormatter.date(from: dateString) else {
              return ""
          }
          
          let outputFormatter = DateFormatter()
          outputFormatter.dateFormat = "yyyy"
          return outputFormatter.string(from: date)
      }
}
