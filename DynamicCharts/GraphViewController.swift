//
//  GraphViewController.swift
//  DynamicCharts
//
//  Created by Sauda Sadaf on 2021-05-13.
//

import UIKit
import Charts
class GraphViewController: UIViewController {

    @IBOutlet weak var monthLbl: UILabel!
    var monthName = "Unknow"
    var index = 0
    
    
    //graph lavel
    @IBOutlet weak var piChartV: PieChartView!
    @IBOutlet weak var barChartV: BarChartView!
    
    @IBOutlet weak var switchCalSeg: UISegmentedControl!
    
    let monthY = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]
    let spendMAmount = [ 300, 4000, 300, 5000, 2000, 1500, 3500, 1200, 3000,  4534,  3400 , 6500]
    
    let weekM = ["Week1", "Week2", "Week3", "Week4",  "Week5"]
    let spendWAmount = [100, 50, 200, 25 ,25 ]
    
    let CategoryAll  = [ "Meals",  "Entertainment",  "Shopping",  "GasTravel" , "Apparel"]
    let catValu = [3000, 4000, 15000,  4000,   1000]
    let weekcatValu = [11,  15, 56,  15,   4]
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        monthLbl.text = monthName
        barChartV.animate(yAxisDuration: 2.0)
        barChartV.pinchZoomEnabled = false
        barChartV.drawBarShadowEnabled = false
        barChartV.drawBordersEnabled = false
        barChartV.doubleTapToZoomEnabled = false
        barChartV.drawGridBackgroundEnabled = true
//        barChartV.minOffset = 0;
        barChartV.leftAxis.axisMinimum = 0.0
        barChartV.rightAxis.axisMinimum = 0

//        barChartV.chartDescription?.text = "Bar Chart View"
        
        setChart(dataPoints: monthY, values: spendMAmount.map { Double($0) })
        

//        setpiChart(dataPoints: CategoryArr, values: catValu)
        setpiChart(dataPoints: CategoryAll, values: catValu.map { Double($0) })
    }
    
    func setChart(dataPoints: [String], values: [Double]) {
        
        barChartV.noDataText = "You need to provide data for the chart."
        var dataEntries: [BarChartDataEntry] = []
      
          for i in 0..<dataPoints.count {
            let dataEntry = BarChartDataEntry(x: Double(i), y: Double(values[i]))
            dataEntries.append(dataEntry)
          }
      
        let chartDataSet = BarChartDataSet(entries: dataEntries, label: "Amount")
        let chartData = BarChartData(dataSet: chartDataSet)
        barChartV.data = chartData
//        barChartV.xAxis.setLabelCount(12, force: true)

        barChartV.xAxis.valueFormatter = IndexAxisValueFormatter(values: dataPoints)
        barChartV.xAxis.granularity = 1
        barChartV.animate(yAxisDuration: 2.0)


    }
    
    
    func setpiChart(dataPoints: [String], values: [Double]) {
        
        var dataEntries: [ChartDataEntry] = []
        
        for i in 0..<dataPoints.count {
            let dataEntry = PieChartDataEntry(value: values[i], label: dataPoints[i], data: dataPoints[i] as AnyObject)
            dataEntries.append(dataEntry)
        }
        
        let pieChartDataSet = PieChartDataSet(entries: dataEntries, label: nil)
        let pieChartData = PieChartData( dataSet: pieChartDataSet)
        let format = NumberFormatter()
        format.numberStyle = .none
        let formatter = DefaultValueFormatter(formatter: format)
        pieChartData.setValueFormatter(formatter)
        
//        piChartV.data = pieChartData
        
        var colors: [UIColor] = []
        
        for i in 0..<dataPoints.count {
            let red = Double(arc4random_uniform(256))
            let green = Double(arc4random_uniform(256))
            let blue = Double(arc4random_uniform(256))
            
            let color = UIColor(red: CGFloat(red/255), green: CGFloat(green/255), blue: CGFloat(blue/255), alpha: 1)
            colors.append(color)
        }
        
        pieChartDataSet.colors = colors
        piChartV.data = pieChartData
        piChartV.animate(xAxisDuration: TimeInterval(2))

        
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
