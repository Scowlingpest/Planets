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
        } else if let number = json as? NSNumber{
            return number.int64Value
        }
        return 0
    }
    
    func jsonToDate(json: Any?) -> Date? {
        //if it's already a date object just throw it back
        if let date = json as? Date {
            return date
        }
        return dateFormatter.date(from: stringOrBlank(json: json))
    }
    
    func jsonToURL(json: Any?) -> URL? {
        //if it's already a url then chuck it back
        if let url = json as? URL {
            return url
        }
       return URL(string: stringOrBlank(json: json))
    }
    
    func stringOrBlank(json: Any?) -> String {
        return jsonToString(json: json) ?? ""
    }
    
    //could alternatively do "\(json)" but I feel this is more what we want, we don't want to convert it to string just identify it is a string
    func jsonToString(json: Any?) -> String? {
        return json as? String
    }
}
