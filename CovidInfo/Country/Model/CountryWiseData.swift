//
//  CountryWiseDate.swift
//  AppypieDemoApp
//
//  Created by Ajay Yadav on 03/09/21.
//

import Foundation
struct CountryWiseData : Codable {
    let iD : String?
    let country : String?
    let countryCode : String?
    let province : String?
    let city : String?
    let cityCode : String?
    let lat : String?
    let lon : String?
    let confirmed : Int?
    let deaths : Int?
    let recovered : Int?
    let active : Int?
    let date : String?

    enum CodingKeys: String, CodingKey {

        case iD = "ID"
        case country = "Country"
        case countryCode = "CountryCode"
        case province = "Province"
        case city = "City"
        case cityCode = "CityCode"
        case lat = "Lat"
        case lon = "Lon"
        case confirmed = "Confirmed"
        case deaths = "Deaths"
        case recovered = "Recovered"
        case active = "Active"
        case date = "Date"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        iD = try values.decodeIfPresent(String.self, forKey: .iD)
        country = try values.decodeIfPresent(String.self, forKey: .country)
        countryCode = try values.decodeIfPresent(String.self, forKey: .countryCode)
        province = try values.decodeIfPresent(String.self, forKey: .province)
        city = try values.decodeIfPresent(String.self, forKey: .city)
        cityCode = try values.decodeIfPresent(String.self, forKey: .cityCode)
        lat = try values.decodeIfPresent(String.self, forKey: .lat)
        lon = try values.decodeIfPresent(String.self, forKey: .lon)
        confirmed = try values.decodeIfPresent(Int.self, forKey: .confirmed)
        deaths = try values.decodeIfPresent(Int.self, forKey: .deaths)
        recovered = try values.decodeIfPresent(Int.self, forKey: .recovered)
        active = try values.decodeIfPresent(Int.self, forKey: .active)
        date = try values.decodeIfPresent(String.self, forKey: .date)
    }

}
