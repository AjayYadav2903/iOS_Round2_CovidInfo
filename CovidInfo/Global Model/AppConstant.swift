//
//  AppConstant.swift
//  AppypieDemoApp
//
//  Created by Mithilesh on 03/09/21.
//

import Foundation
import UIKit

struct APIConstant {
    static let countryList = "https://api.covid19api.com/countries"
    static let countryListData = "https://api.covid19api.com/live/country/"

}

//MARK: - General Objects
struct CovidInfo
{
    static let kAppDelegate = UIApplication.shared.delegate as! AppDelegate
    static let kUserDefaults = UserDefaults.standard
}
