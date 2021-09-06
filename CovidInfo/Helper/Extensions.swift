//
//  Extensions.swift
//  AppypieDemoApp
//
//  Created by Ajay Yadav on 03/09/21.
//

import Foundation


extension String {
    func flag(country:String) -> String {
        let base = 127397
        var usv = String.UnicodeScalarView()
        for i in country.utf16 {
            usv.append(UnicodeScalar(base + Int(i))!)
        }
        return String(usv)
    }
}
