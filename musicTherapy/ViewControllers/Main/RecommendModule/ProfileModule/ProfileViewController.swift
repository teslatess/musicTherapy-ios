//
//  MTProfileViewController.swift
//  musicTherapy
//
//  Created by kkerors on 09.01.2021.
//

import Foundation
import UIKit
import SnapKit
import Firebase
import Charts

class ProfileViewController : UIViewController {
    
    // MARK: UIVIEW
    
    private let mainView = UIView()
    
    private let stateContainer = UIView()
    
    private let currentStateLabel = UILabel()
    
    private let preasureStateLabel = UILabel()
    
    private let lineChartContainer = UIView()
    
    private lazy var lineChartView : LineChartView = {
        let chartView = LineChartView()
        return chartView
    }()
    
    let yValues : [ChartDataEntry] = [
        ChartDataEntry(x: 1.0, y: -1.0, data: "123"),
        ChartDataEntry(x: 2.0, y: 1.0, data: "123"),
        ChartDataEntry(x: 3.0, y: 3.0, data: "123"),
        ChartDataEntry(x: 4.0, y: -4.0, data: "123")
        
    ]
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        self.view.addSubview(self.mainView)
        self.mainView.addSubview(self.stateContainer)
        self.mainView.addSubview(self.lineChartContainer)
        
        self.stateContainer.addSubview(self.currentStateLabel)
        self.stateContainer.addSubview(self.preasureStateLabel)
        
        self.lineChartContainer.addSubview(self.lineChartView)
        
        self.lineChartView.delegate = self
        
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.title = "Профиль"
        self.navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        
        let profileBarButtonItem = UIBarButtonItem(title: "Выйти", style: .done, target: self, action: #selector(onLogout))
            self.navigationItem.rightBarButtonItem  = profileBarButtonItem
        
        self.setupViews()
        self.setupSubview()
        self.view.layoutSubviews()
        
    }
    
    // MARK: SETUP UIVIEW
    
    private func setupViews(){
        self.setupMainView()
        self.setupStateContainer()
        self.setupLineChartContainer()
        self.setupLineChartView()
    }
    
    private func setupMainView(){
        self.mainView.backgroundColor = .white
    }
    
    private func setupStateContainer() {
        self.stateContainer.backgroundColor = .white
        self.stateContainer.layer.cornerRadius = 10
        self.stateContainer.layer.shadowRadius = 5
        self.stateContainer.layer.shadowOpacity = 0.3
        
        self.currentStateLabel.textColor = .black
        self.currentStateLabel.text = "Текущее состояние"
        self.currentStateLabel.font = UIFont.boldSystemFont(ofSize: 15)
        
        let stringArray = ["Верхнее давление - 120", "Нижнее давление - 80", "Пульс - 90", "Настроение - Спокойное"]
        self.preasureStateLabel.attributedText = NSAttributedStringHelper.createBulletedList(fromStringArray: stringArray, font: UIFont.systemFont(ofSize: 13))
        self.preasureStateLabel.numberOfLines = 0
        self.preasureStateLabel.textColor = .black
        
    }
    
    private func setupLineChartContainer() {
        self.lineChartContainer.backgroundColor = .white
        self.lineChartContainer.layer.cornerRadius = 10
        self.lineChartContainer.layer.shadowRadius = 5
        self.lineChartContainer.layer.shadowOpacity = 0.3
    }
    
    private func setupLineChartView() {
        self.setData()
        self.lineChartView.backgroundColor = .black
        self.lineChartView.rightAxis.enabled = false
        self.lineChartView.animate(xAxisDuration: 1.5)
        
    }
    
    private func setData() {
        
        let set1 = LineChartDataSet(entries: yValues, label: "самочувствие")
        
        set1.drawCirclesEnabled = false
        set1.lineWidth = 2
        set1.setColor(.white)
        set1.mode = .cubicBezier
        
        let data = LineChartData(dataSet: set1)
        self.lineChartView.data = data
    }
    
    // MARK: SETUP CONSTRAINTS
    
    private func setupSubview() {
        self.mainView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        self.stateContainer.snp.makeConstraints {
            $0.top.equalTo(self.mainView).offset(topBarHeight)
            $0.left.equalTo(self.mainView).offset(30)
            $0.right.equalTo(self.mainView).offset(-30)
            $0.bottom.equalTo(self.mainView.snp.centerY).offset(-10)
        }
        
        self.currentStateLabel.snp.makeConstraints {
            $0.top.equalTo(self.stateContainer).offset(10)
            $0.centerX.equalTo(self.stateContainer)
        }
        
        self.preasureStateLabel.snp.makeConstraints {
            $0.left.equalTo(self.stateContainer).offset(10)
            $0.right.equalTo(self.stateContainer).offset(-10)
            $0.centerY.equalTo(self.stateContainer)
        }
        
        self.lineChartContainer.snp.makeConstraints {
            $0.top.equalTo(self.mainView.snp.centerY)
            $0.left.equalTo(self.mainView.snp.left).offset(30)
            $0.right.equalTo(self.mainView.snp.right).offset(-30)
            $0.bottom.equalTo(self.mainView.snp.bottom).offset(-self.bottomHeight)
        }
        
        self.lineChartView.snp.makeConstraints {
            $0.left.equalTo(self.lineChartContainer.snp.left).offset(10)
            $0.right.equalTo(self.lineChartContainer.snp.right).offset(-10)
            $0.top.equalTo(self.lineChartContainer.snp.top).offset(10)
            $0.bottom.equalTo(self.lineChartContainer.snp.bottom).offset(-10)
        }
        
    }
    
    @objc func onLogout() {
        
        print("logout")
        
        do { try Auth.auth().signOut()
            LoginRouting.presentLoginViewController(fromVC: self)
        }
        
        catch { print("already logged out") }
    }
    
}

extension ProfileViewController : ChartViewDelegate {
    
    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
        print(entry)
    }
    
}

class NSAttributedStringHelper {
    static func createBulletedList(fromStringArray strings: [String], font: UIFont? = nil) -> NSAttributedString {

        let fullAttributedString = NSMutableAttributedString()
        let attributesDictionary: [NSAttributedString.Key: Any]

        if font != nil {
            attributesDictionary = [NSAttributedString.Key.font: font!]
        } else {
            attributesDictionary = [NSAttributedString.Key: Any]()
        }

        for index in 0..<strings.count {
            let bulletPoint: String = "\u{2022}"
            var formattedString: String = "\(bulletPoint) \(strings[index])"

            if index < strings.count - 1 {
                formattedString = "\(formattedString)\n"
            }

            let attributedString: NSMutableAttributedString = NSMutableAttributedString(string: formattedString, attributes: attributesDictionary)
            let paragraphStyle = NSAttributedStringHelper.createParagraphAttribute()
   attributedString.addAttributes([NSAttributedString.Key.paragraphStyle: paragraphStyle], range: NSMakeRange(0, attributedString.length))
        fullAttributedString.append(attributedString)
       }

        return fullAttributedString
    }

    private static func createParagraphAttribute() -> NSParagraphStyle {
        let paragraphStyle: NSMutableParagraphStyle = NSParagraphStyle.default.mutableCopy() as! NSMutableParagraphStyle
        paragraphStyle.tabStops = [NSTextTab(textAlignment: .left, location: 15, options: NSDictionary() as! [NSTextTab.OptionKey : Any])]
        paragraphStyle.defaultTabInterval = 15
        paragraphStyle.firstLineHeadIndent = 0
        paragraphStyle.headIndent = 11
        return paragraphStyle
    }
}
