//
//  CountryListVC.swift
//  CovidInfo
//
//  Created by Ajay Yadav on 02/09/21.
//

import UIKit

class CountryWiseDataVC: UIViewController {
    
    @IBOutlet weak var lblCountryName: UILabel!
    @IBOutlet weak var lblFlag: UILabel!

    @IBOutlet weak var tblList: UITableView!
    var objCountry:Country?

    var objCountryModel:CountryWiseDataModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
        self.lblCountryName.text = objCountry?.Country ?? ""
        self.lblFlag.text = "\("".flag(country: objCountry?.ISO2 ?? "") )"
    }
    
    func initialSetup(){
        tblList.register(UINib(nibName: "CountryWiseDataCell", bundle: .main), forCellReuseIdentifier: "CountryWiseDataCell")
        tblList.delegate = self
        tblList.dataSource = self
        objCountryModel = CountryWiseDataModel()
        updataCountryList()
        objCountryModel?.getCountryList(urlStr: "\(APIConstant.countryListData)\(objCountry?.Slug ?? "")/status/active")
//        fetchRequest()
        
    }
    
    
    @IBAction func btnOpenChartsAction(_ sender: Any) {
        let countryWiseDataVC = ChartsViewController()
        countryWiseDataVC.objCountryModel = self.objCountryModel
        self.present(countryWiseDataVC, animated: true) {
            
        }
    }
    
    @IBAction func btnFetchAction(_ sender: Any) {
        objCountryModel?.getCountryList(urlStr: "\(APIConstant.countryListData)\(objCountry?.Slug ?? "")/status/active")
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
                self.tblList.reloadData()
            }
        }
    }
}


extension CountryWiseDataVC:UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objCountryModel?.arrCountryList.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CountryWiseDataCell", for: indexPath) as? CountryWiseDataCell,objCountryModel?.arrCountryList.count ?? 0 > indexPath.row else{
            return UITableViewCell()
        }
        let objEmployee = objCountryModel?.arrCountryList[indexPath.row]
        cell.lblConfirmed.text = "\(objEmployee?.confirmed ?? 0)"
        cell.lblRecovered.text = "\(objEmployee?.recovered ?? 0)"
        cell.lblDeath.text = "\(objEmployee?.deaths ?? 0)"
        var datee : String?
        datee = objEmployee?.date
               // "2021-06-25T00:00:00Z"
        if let objDate = datee {
            let inputFormatter = DateFormatter()
            inputFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
            let showDate = inputFormatter.date(from: (objDate))
            inputFormatter.dateFormat = "MMM d, h:mm a"
            let resultString : String?
            if showDate != nil {
                resultString = inputFormatter.string(from: showDate!)
                cell.lblDate.text = resultString
            }else {
                cell.lblDate.text = objDate
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return objCountryModel?.heightForRowAtIndexPath() ?? 0
    }
}

