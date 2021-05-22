//
//  PhysicalParametersViewController.swift
//  musicTherapy
//
//  Created by kkerors on 10.01.2021.
//

import Foundation
import UIKit
import SnapKit

class PhysicalParametersViewController : UIViewController {
    
    // MARK: UIVIEW
    
    private let mainView = UIView()
    private let upperPreasureTextField = DefaultTextField()
    private let lowerPreasureTextField = DefaultTextField()
    private let pulseTextField = DefaultTextField()
//    private let moodSlider = UISlider()
    private let nextButton = SampleButton()
    
    private var upperPreasure : Int?
    private var lowerPreasure : Int?
    private var pulse : Int?
    private var mood : MoodType?
    
    private var audioSession = AudioSession()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupLargeTitle(title: "Параметры")
        
        self.view.addSubview(self.mainView)
        self.mainView.addSubview(self.upperPreasureTextField)
        self.mainView.addSubview(self.lowerPreasureTextField)
        self.mainView.addSubview(self.pulseTextField)
        self.mainView.addSubview(self.nextButton)
//        self.mainView.addSubview(self.moodSlider)
        
        self.setupViews()
        self.setupSubview()
        self.view.layoutSubviews()
        
    }
    
    // MARK: SETUP UIVIEW
    
    private func setupViews(){
        self.setupMainView()
        self.setupUpperPreasureTextField()
        self.setupLowerPreasureTextField()
        self.setupPulseTextField()
//        self.setupMoodSlider()
        self.setupNextButton()
    }
    
    private func setupMainView(){
        self.mainView.backgroundColor = .white
    }
    
    private func setupUpperPreasureTextField(){
        self.upperPreasureTextField.setPlaceholder("Верхнее давление")
        self.upperPreasureTextField.keyboardType = .numberPad
    }
    
    private func setupLowerPreasureTextField(){
        self.lowerPreasureTextField.setPlaceholder("Нижнее давление")
        self.lowerPreasureTextField.keyboardType = .numberPad
    }
    
    private func setupPulseTextField(){
        self.pulseTextField.setPlaceholder("Пульс")
        self.pulseTextField.keyboardType = .numberPad
    }
    
//    private func setupMoodSlider() {
//        self.moodSlider.tintColor = .black
//    }
    
    private func setupNextButton() {
        self.nextButton.mainLabel.text = "Далее"
        self.nextButton.mainLabel.textColor = .white
        self.nextButton.backgroundColor = .black
        self.nextButton.layer.cornerRadius = 10
        self.nextButton.layer.masksToBounds = true
        self.nextButton.addTarget(self, action: #selector(onNextClick), for: .touchDown)
    }
    
    private func checkData() {
        
        if self.upperPreasure != nil && self.lowerPreasure != nil && self.pulse != nil {
            self.saveParams()
            EmotionalParametersRouting.presentEmotionalParametersViewController(fromVC: self, audioSession: self.audioSession)
        }
        
    }
    
    private func saveParams() {
        self.audioSession.physicalParams.upperPreasure = self.upperPreasure
        self.audioSession.physicalParams.lowerPreasure = self.lowerPreasure
        self.audioSession.physicalParams.pulse = self.pulse
    }

    @objc func onNextClick() {
        self.upperPreasure = Int(self.upperPreasureTextField.text ?? "")
        self.lowerPreasure = Int(self.lowerPreasureTextField.text ?? "")
        self.pulse = Int(self.pulseTextField.text ?? "")
        self.checkData()
    }
    
    // MARK: SETUP CONSTRAINTS
    
    private func setupSubview() {
        self.mainView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        self.upperPreasureTextField.snp.makeConstraints {
            $0.left.equalTo(self.mainView.snp.left).offset(30)
            $0.right.equalTo(self.mainView.snp.right).offset(-30)
            $0.top.equalTo(self.mainView.snp.top).offset(self.topBarHeight)
        }
        self.lowerPreasureTextField.snp.makeConstraints {
            $0.left.equalTo(self.mainView.snp.left).offset(30)
            $0.right.equalTo(self.mainView.snp.right).offset(-30)
            $0.top.equalTo(self.upperPreasureTextField.snp.bottom).offset(30)
        }
        self.pulseTextField.snp.makeConstraints {
            $0.left.equalTo(self.mainView.snp.left).offset(30)
            $0.right.equalTo(self.mainView.snp.right).offset(-30)
            $0.top.equalTo(self.lowerPreasureTextField.snp.bottom).offset(30)
        }
//        self.moodSlider.snp.makeConstraints {
//            $0.top.equalTo(self.pulseTextField.snp.bottom).offset(30)
//            $0.left.equalTo(self.mainView.snp.left).offset(30)
//            $0.right.equalTo(self.mainView.snp.right).offset(-30)
//            $0.height.equalTo(30)
//        }
        self.nextButton.snp.makeConstraints {
            $0.left.equalTo(self.mainView.snp.left).offset(30)
            $0.right.equalTo(self.mainView.snp.right).offset(-30)
            $0.bottom.equalTo(self.mainView.snp.bottom).offset(-self.bottomHeight)
            $0.height.equalTo(56)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
}
