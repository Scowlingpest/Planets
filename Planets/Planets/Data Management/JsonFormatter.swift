//
//  JsonFormatter.swift
//  Planets
//
//  Created by Pip Elise Russell on 12/10/2019.
//  Copyright © 2019 Pip Elise Russell. All rights reserved.
//

import Foundation


class JsonFormatter {
    private var dateFormatter: DateFormatter
    
    init() {
        dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSSZ"
        
    }
    func jsonToInt(json: Any?) -> Int64 {
        if let transformed = Int64(stringOrBlank(json: json)) {
            return transformed
        }
        return 0
    }
    
    func jsonToDate(json: Any?) -> Date? {
        return dateFormatter.date(from: stringOrBlank(json: json))
    }
    
    func jsonToURL(json: Any?) -> URL? {
       return URL(string: stringOrBlank(json: json))
    }
    
    func stringOrBlank(json: Any?) -> String {
        return jsonToString(json: json) ?? ""
    }
    
    func jsonToString(json: Any?) -> String? {
        return json as? String
    }
}
