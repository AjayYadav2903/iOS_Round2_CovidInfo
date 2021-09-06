//
//  StorageSingleton.swift
//  AppypieDemoApp
//
//  Created by Ajay Yadav on 05/09/21.
//

import Foundation

open class StorageSingleton   {

   public static let sharedInstance: StorageSingleton = StorageSingleton()
    
    private init(){}
    
    var arrCountryList:[Country] = []

    
}
