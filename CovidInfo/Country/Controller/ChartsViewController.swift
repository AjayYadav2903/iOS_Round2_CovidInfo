//
//  ChartsViewController.swift
//  CovidInfo
//
//  Created by Ajay Yadav on 02/09/21.
//

import Foundation
import UIKit
import PieCharts
import Highcharts

class ChartsViewController: UIViewController {
    
    @IBOutlet weak var highChart : HIChartView!
    var objCountryModel:CountryWiseDataModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let options = HIOptions()
        
        let chart = HIChart()
        chart.type = "pie"
        options.chart = chart
        
        
        let title = HITitle()
        title.text = "Touch for Info about Cases"
        options.title = title

        let plotOptions = HIPlotOptions()
        plotOptions.pie = HIPie()
        plotOptions.pie.shadow = HIShadowOptionsObject()
        plotOptions.pie.shadow.width = 0
        plotOptions.pie.center = ["50%", "50%"]
        options.plotOptions = plotOptions
        
        chart.options3d = HIOptions3d()
        chart.options3d.enabled = true
        chart.options3d.alpha = 45
        chart.options3d.beta = 0
        options.chart = chart
        
        let versions = HIPie()
        versions.name = "Cases"
        versions.size = "80%"
        versions.innerSize = "60%"
        
        let dataLabelsVersions = HIDataLabels()
        dataLabelsVersions.formatter = HIFunction(jsFunction: "function () { return this.y > 1 ? '<b>' + this.point.name + ':</b> ' + this.y + '%' : null; }")
        versions.dataLabels = [dataLabelsVersions]
        versions.id = "versions"
        
        versions.data = [[
            "name": "Recoverd",
            "y": Double(objCountryModel?.arrCountryList[0].recovered ?? 0),
            "color": "rgb(0,128,0)"
        ], [
            "name": "Confirmed",
            "y": Double(objCountryModel?.arrCountryList[0].confirmed ?? 0),
            "color": "rgb(135,206,235)"
        ],[
            "name": "Deaths",
            "y": Double(objCountryModel?.arrCountryList[0].deaths ?? 0),
            "color": "rgb(255,0,0)"
        ]]
        
        options.series = [versions]
        
        let responsive = HIResponsive()
        let rule = HIRules()
        rule.condition = HICondition()
        rule.condition.maxWidth = 400
        rule.chartOptions = [
            "series": [
                "id": "versions",
                "dataLabels": [
                    "enabled": false
                ]
            ]
        ]
        responsive.rules = [rule]
        options.responsive = responsive
        
        highChart.options = options
    }
}
