//
//  CountryListVC.swift
//  CovidInfo
//
//  Created by Ajay Yadav on 02/09/21.
//

import UIKit
import CoreData

class CountryListVC: UIViewController {
    
    @IBOutlet weak var tblList: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!

    var objCountryModel:CountryDataModel?
    var headerValues = ["Recently Visited","Country"]
    var context = CovidInfo.kAppDelegate.persistentContainer.viewContext
    var arrOfflineList = [CountryOffline]()

    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
    }
    
    func initialSetup(){
        searchBar.searchTextField.clearButtonMode = .never
        tblList.register(UINib(nibName: "CountryListCell", bundle: .main), forCellReuseIdentifier: "CountryListCell")
        tblList.delegate = self
        tblList.dataSource = self
        objCountryModel = CountryDataModel()
        updataCountryList()
        objCountryModel?.getCountryList(urlStr: APIConstant.countryList)
//        fetchRequest()
        
    }
    
    

    @IBAction func btnFetchAction(_ sender: Any) {
        objCountryModel?.getCountryList(urlStr: APIConstant.countryList)
    }
    
    @IBAction func btnDelete(_ sender: Any) {
        objCountryModel?.arrCountryList = []
        DispatchQueue.main.async {
            self.tblList.reloadData()
        }
    }

    func updataCountryList(){
        objCountryModel?.isDataLoaded = {(isViewLoaded) in
            DispatchQueue.main.async {
                StorageSingleton.sharedInstance.arrCountryList = self.objCountryModel?.arrCountryList ?? []
                self.tblList.reloadData()
            }
        }
    }
}


extension CountryListVC:UITableViewDelegate,UITableViewDataSource{
   
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return getAllOfflineItems()?.count ?? 0
        }
        return objCountryModel?.arrCountryList.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "CountryListCell", for: indexPath) as? CountryListCell,getAllOfflineItems()?.count ?? 0 > indexPath.row else{
                return UITableViewCell()
            }
            let objEmployee = getAllOfflineItems()?[indexPath.row]
            //let s = flag(country: objEmployee?.ISO2 ?? "")
            cell.lblCountryName.text = "Country: \(objEmployee?.countryO ?? "")"
            cell.lblCountryFlag.text = "\("".flag(country: objEmployee?.iso2O ?? "") )"
            cell.lblSlug.text = "Slug: \(objEmployee?.slugO ?? "")"
            cell.lblIso2.text = "ISO2: \(objEmployee?.iso2O ?? "")"
            return cell
        }
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CountryListCell", for: indexPath) as? CountryListCell,objCountryModel?.arrCountryList.count ?? 0 > indexPath.row else{
            return UITableViewCell()
        }
        let objEmployee = objCountryModel?.arrCountryList[indexPath.row]
        //let s = flag(country: objEmployee?.ISO2 ?? "")
        cell.lblCountryName.text = "Country: \(objEmployee?.Country ?? "")"
        cell.lblCountryFlag.text = "\("".flag(country: objEmployee?.ISO2 ?? "") )"
        cell.lblSlug.text = "Slug: \(objEmployee?.Slug ?? "")"
        cell.lblIso2.text = "ISO2: \(objEmployee?.ISO2 ?? "")"
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return objCountryModel?.heightForRowAtIndexPath() ?? 0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            let objCountry = getAllOfflineItems()?[indexPath.row]
            let countryWiseDataVC = CountryWiseDataVC()
            let objCountryMap = Country()
            objCountryMap.Country = objCountry?.countryO
            objCountryMap.Slug = objCountry?.slugO
            objCountryMap.ISO2 = objCountry?.iso2O
            countryWiseDataVC.objCountry = objCountryMap
            self.present(countryWiseDataVC, animated: true) {
            }
        }else {
            
            let objCountry = objCountryModel?.arrCountryList[indexPath.row]
            var isDuplicateFound = false
            
            if getAllOfflineItems()?.count ?? 0 > 0 {
                for item in getAllOfflineItems()! {
                    if item.countryO == objCountry?.Country {
                        isDuplicateFound = true
                        break
                    }
                }
            }
            if !isDuplicateFound {
                let items = NSEntityDescription.insertNewObject(forEntityName: "CountryOffline", into: self.context) as! CountryOffline
                items.countryO = objCountry?.Country
                items.slugO = objCountry?.Slug
                items.iso2O = objCountry?.ISO2
                do {
                    
                    try self.context.save()
                    DispatchQueue.main.async {
                        self.tblList.reloadData()
                    }
                } catch  {
                    print("data is not saved")
                }
            }
            
            let countryWiseDataVC = CountryWiseDataVC()
            countryWiseDataVC.objCountry = objCountry
            self.present(countryWiseDataVC, animated: true) {
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return headerValues[section]
    }
    
}

extension CountryListVC : UISearchBarDelegate {
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard let searchText = searchBar.text, !searchText.isEmpty else { return }

        let filteredArr = StorageSingleton.sharedInstance.arrCountryList
        let filterArr = filteredArr.filter({ (obj1) -> Bool in
            if searchText == "" {
            }else{
                if obj1.Country!.uppercased().contains(searchText.uppercased()) {
                    return true
                }
            }
            return false
        })
        
        if searchText == "" {
            objCountryModel?.arrCountryList = StorageSingleton.sharedInstance.arrCountryList
        }else {
            objCountryModel?.arrCountryList = filterArr
        }
        DispatchQueue.main.async {
            self.tblList.reloadData()
        }
    }
}

extension CountryListVC{
    func getAllOfflineItems() -> [CountryOffline]?  {
        var product = [CountryOffline]()
        do {
            let fetchRequest = NSFetchRequest<NSManagedObject>(entityName : "CountryOffline")
            product = try self.context.fetch(fetchRequest) as! [CountryOffline]
            let sortedStudents = product.sorted { (lhs: CountryOffline, rhs: CountryOffline) -> Bool in
                return lhs.countryO ?? "" < rhs.countryO ?? ""
            }
            return sortedStudents
        } catch  {
            print("can not get data")
        }
        let sortedStudents = product.sorted { (lhs: CountryOffline, rhs: CountryOffline) -> Bool in
            return lhs.countryO ?? "" < rhs.countryO ?? ""
        }
        

        return sortedStudents
    }
}
