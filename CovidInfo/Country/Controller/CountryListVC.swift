//
//  CountryListVC.swift
//  CovidInfo
//
//  Created by Ajay Yadav on 02/09/21.
//

import UIKit

class CountryListVC: UIViewController {
    
    @IBOutlet weak var tblList: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!

    var objCountryModel:CountryDataModel?
    
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objCountryModel?.arrCountryList.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
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
        let objEmployee = objCountryModel?.arrCountryList[indexPath.row]

        let countryWiseDataVC = CountryWiseDataVC()
        countryWiseDataVC.objCountry = objEmployee
        self.present(countryWiseDataVC, animated: true) {
            
        }
        
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
