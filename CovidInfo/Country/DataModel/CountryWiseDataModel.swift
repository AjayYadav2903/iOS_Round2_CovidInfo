//
//  CountryWiseDataModel.swift
//  CovidInfo
//
//  Created by Ajay Yadav on 02/09/21.
//

import UIKit
class CountryWiseDataModel: NSObject {

    var isDataLoaded:((Bool)->Void)?
    var arrCountryList:[CountryWiseData] = []
    
    func getCountryList(urlStr:String){
        ServerCommunication.getData(urlStr: urlStr) { data in
            if let data = data as? Data{
                self.parseData(data: data)
            }
        }
    }
    
    func parseData(data:Data){
        do{
            arrCountryList = try JSONDecoder().decode([CountryWiseData].self, from: data)
            isDataLoaded?(true)
        }
        catch{
            print(error.localizedDescription)
        }
    }
    
    func heightForRowAtIndexPath()->CGFloat{
        return 160.0
    }    
}
