//
//  ColorTestViewController.swift
//  musicTherapy
//
//  Created by kkerors on 08.02.2021.
//

import Foundation
import UIKit
import SnapKit

class ColorTestViewController : UIViewController {
    
    // MARK: UIVIEW
    
    private let mainView = UIView()
    private let colorCollectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout.init())
    private let colorArray = [UIColor.black, UIColor.brown, UIColor.purple, UIColor.gray, UIColor.blue, UIColor.red, UIColor.green, UIColor.yellow]
    
    // MARK: AUDIO ARRAY
    
    var audioArray : [Track?] = []
    var currentAudioArray : [Track?] = []
    var trackType : TrackType?
    var audioSession = AudioSession()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupLargeTitle(title: "Выберите цвет")
        
        self.view.addSubview(self.mainView)
        self.mainView.addSubview(colorCollectionView)
        
        self.colorCollectionView.delegate = self
        self.colorCollectionView.dataSource = self
        
        let colorCollectionViewCell = UINib(nibName: "ColorCollectionViewCell",
                                      bundle: nil)
        self.colorCollectionView.register(colorCollectionViewCell, forCellWithReuseIdentifier: "ColorCollectionViewCell")
        
        self.setupTrackArray()
        self.setupViews()
        self.setupSubview()
        self.view.layoutSubviews()
        
    }
    
    // MARK: SETUP TRACK ARRAY
    
    private func setupTrackArray() {
        
        // Black
        
        let black1 = Track(id: "0", author: "Альбиони", name: "Адажио", time: "0:12", type: .black, image: UIImage(named: "defaultSoundIcon"), path: "MusicAssets/Black/Альбиони Адажио", state: .stop)
        let black2 = Track(id: "1", author: "Брамс", name: "Симфония №3", time: "0:12", type: .black, image: UIImage(named: "defaultSoundIcon"), path: "MusicAssets/Black/Брамс симфония №3 (2 часть)", state: .stop)
        let black3 = Track(id: "2", author: "Глинка", name: "Прощание", time: "0:12", type: .black, image: UIImage(named: "defaultSoundIcon"), path: "MusicAssets/Black/Глинка Прощание", state: .stop)
        let black4 = Track(id: "3", author: "Марчелло", name: "Концерт для гобоя", time: "0:12", type: .black, image: UIImage(named: "defaultSoundIcon"), path: "MusicAssets/Black/Марчелло Концерт для гобоя", state: .stop)
        let black5 = Track(id: "4", author: "Террега", name: "Воспоминание об Альгамбре", time: "0:12", type: .black, image: UIImage(named: "defaultSoundIcon"), path: "MusicAssets/Black/Террега Воспоминание об Альгамбре", state: .stop)
        
        // Blue
        
        let blue1 = Track(id: "5", author: "Бетховен", name: "Концерт №5 (часть 2)", time: "0:12", type: .blue, image: UIImage(named: "defaultSoundIcon"), path: "MusicAssets/Blue/Бетховен Концерт №5 (часть 2)", state: .stop)
        let blue2 = Track(id: "6", author: "Григ", name: "Весна", time: "0:12", type: .blue, image: UIImage(named: "defaultSoundIcon"), path: "MusicAssets/Blue/Григ Весна", state: .stop)
        let blue3 = Track(id: "7", author: "Шопен", name: "Фантазия экспромт", time: "0:12", type: .blue, image: UIImage(named: "defaultSoundIcon"), path: "MusicAssets/Blue/Шопен Фантазия экспромт", state: .stop)
        
        // Brown
        
        let brown1 = Track(id: "8", author: "Бетховен", name: "К Элизе", time: "0:12", type: .brown, image: UIImage(named: "defaultSoundIcon"), path: "MusicAssets/Brown/Бетховен К Элизе", state: .stop)
        let brown2 = Track(id: "9", author: "Григ", name: "Песня Сольвейг", time: "0:12", type: .brown, image: UIImage(named: "defaultSoundIcon"), path: "MusicAssets/Brown/Григ Песня Сольвейг", state: .stop)
        let brown3 = Track(id: "10", author: "Дворжак", name: "Мелодия", time: "0:12", type: .brown, image: UIImage(named: "defaultSoundIcon"), path: "MusicAssets/Brown/Дворжак Мелодия", state: .stop)
        let brown4 = Track(id: "11", author: "Рахманинов", name: "Вокализ", time: "0:12", type: .brown, image: UIImage(named: "defaultSoundIcon"), path: "MusicAssets/Brown/Рахманинов Вокализ", state: .stop)
        let brown5 = Track(id: "12", author: "Чайковский", name: "Осенняя песня", time: "0:12", type: .brown, image: UIImage(named: "defaultSoundIcon"), path: "MusicAssets/Brown/Чайковский Осенняя песня", state: .stop)
        
        // Green
        
        let green1 = Track(id: "13", author: "Бах", name: "Прелюдия №1", time: "0:12", type: .green, image: UIImage(named: "defaultSoundIcon"), path: "MusicAssets/Green/Бах Прелюдия №1", state: .stop)
        let green2 = Track(id: "14", author: "Моцарт", name: "Эльвира Мадиган", time: "0:12", type: .green, image: UIImage(named: "defaultSoundIcon"), path: "MusicAssets/Green/Моцарт Эльвира Мадиган", state: .stop)
        let green3 = Track(id: "15", author: "Шуберт", name: "Экспромт", time: "0:12", type: .green, image: UIImage(named: "defaultSoundIcon"), path: "MusicAssets/Green/Шуберт Экспромт", state: .stop)
        
        // Grey
        
        let grey1 = Track(id: "15", author: "Скрябин", name: "Этюд", time: "0:12", type: .grey, image: UIImage(named: "defaultSoundIcon"), path: "MusicAssets/Grey/Скрябин Этюд", state: .stop)
        let grey2 = Track(id: "16", author: "Шуберт", name: "Баркарола", time: "0:12", type: .grey, image: UIImage(named: "defaultSoundIcon"), path: "MusicAssets/Grey/Шуберт Баркарола", state: .stop)
        let grey3 = Track(id: "17", author: "Шуман", name: "Интермеццо", time: "0:12", type: .grey, image: UIImage(named: "defaultSoundIcon"), path: "MusicAssets/Grey/Шуман Интермеццо", state: .stop)
        
        // Purple
        
        let purple1 = Track(id: "18", author: "Бородин", name: "Хор полонянок", time: "0:12", type: .purple, image: UIImage(named: "defaultSoundIcon"), path: "MusicAssets/Purple/Бородин Хор полонянок", state: .stop)
        let purple2 = Track(id: "19", author: "Григ", name: "Сердце поэта", time: "0:12", type: .purple, image: UIImage(named: "defaultSoundIcon"), path: "MusicAssets/Purple/Григ Сердце поэта", state: .stop)
        let purple3 = Track(id: "20", author: "Шопен", name: "Ноктюрн", time: "0:12", type: .purple, image: UIImage(named: "defaultSoundIcon"), path: "MusicAssets/Purple/Шопен Ноктюрн", state: .stop)
        
        // Red
        
        let red1 = Track(id: "21", author: "Паганини", name: "Концерт №2 (часть 2)", time: "0:12", type: .red, image: UIImage(named: "defaultSoundIcon"), path: "MusicAssets/Red/Паганини концерт №2 (часть 2)", state: .stop)
        let red2 = Track(id: "22", author: "Шопен", name: "Этюд 25 №1", time: "0:12", type: .red, image: UIImage(named: "defaultSoundIcon"), path: "MusicAssets/Red/Шопен Этюд 25 №1", state: .stop)
        let red3 = Track(id: "23", author: "Шуберт", name: "Аве Мария", time: "0:12", type: .red, image: UIImage(named: "defaultSoundIcon"), path: "MusicAssets/Red/Шуберт Аве Мария", state: .stop)
        
        // Yellow

        let yellow1 = Track(id: "24", author: "Григ", name: "Свадебный день в Тродльхаусе", time: "0:12", type: .yellow, image: UIImage(named: "defaultSoundIcon"), path: "MusicAssets/Yellow/Григ Свадебный день в Тродльхаусе", state: .stop)
        let yellow2 = Track(id: "25", author: "Шопен", name: "Прелюдия", time: "0:12", type: .yellow, image: UIImage(named: "defaultSoundIcon"), path: "MusicAssets/Yellow/Шопен Прелюдия", state: .stop)
        let yellow3 = Track(id: "26", author: "Шопен", name: "Этюд 10 №3", time: "0:12", type: .yellow, image: UIImage(named: "defaultSoundIcon"), path: "MusicAssets/Yellow/Шопен Этюд 10 №3", state: .stop)
        
        self.audioArray.append(black1)
        self.audioArray.append(black2)
        self.audioArray.append(black3)
        self.audioArray.append(black4)
        self.audioArray.append(black5)
        
        self.audioArray.append(blue1)
        self.audioArray.append(blue2)
        self.audioArray.append(blue3)
        
        self.audioArray.append(brown1)
        self.audioArray.append(brown2)
        self.audioArray.append(brown3)
        self.audioArray.append(brown4)
        self.audioArray.append(brown5)
        
        self.audioArray.append(green1)
        self.audioArray.append(green2)
        self.audioArray.append(green3)
        
        self.audioArray.append(grey1)
        self.audioArray.append(grey2)
        self.audioArray.append(grey3)
        
        self.audioArray.append(purple1)
        self.audioArray.append(purple2)
        self.audioArray.append(purple3)
        
        self.audioArray.append(red1)
        self.audioArray.append(red2)
        self.audioArray.append(red3)
        
        self.audioArray.append(yellow1)
        self.audioArray.append(yellow2)
        self.audioArray.append(yellow3)
        
    }
    
    private func sortByType (type: TrackType?) {
        for i in audioArray {
            if i?.type == type {
                self.currentAudioArray.append(i)
            }
        }
    }
    
    // MARK: SETUP UIVIEW
    
    private func setupViews(){
        self.setupMainView()
        self.setupColorCollectionView()
    }
    
    private func setupMainView(){
        self.mainView.backgroundColor = .white
    }
    
    private func setupColorCollectionView() {
        self.colorCollectionView.backgroundColor = .white
    }
    
    // MARK: SETUP CONSTRAINTS
    
    private func setupSubview() {
        
        self.mainView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        self.colorCollectionView.snp.makeConstraints {
            $0.top.equalTo(self.mainView.snp.top).offset(self.topBarHeight)
            $0.left.equalTo(self.mainView.snp.left).offset(10)
            $0.right.equalTo(self.mainView.snp.right).offset(-10)
            $0.bottom.equalTo(self.mainView.snp.bottom)
        }
        
    }
    
}

extension ColorTestViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = (collectionView.dequeueReusableCell(withReuseIdentifier: "ColorCollectionViewCell", for: indexPath) as? ColorCollectionViewCell)!
        cell.mainView.backgroundColor = colorArray[indexPath.row]
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        switch colorArray[indexPath.row] {
        case .black:
            trackType = .black
        case .brown:
            trackType = .brown
        case .purple:
            trackType = .purple
        case .gray:
            trackType = .grey
        case .blue:
            trackType = .blue
        case .red:
            trackType = .red
        case .green:
            trackType = .green
        case .yellow:
            trackType = .yellow
        default:
            return
        }
        
        self.sortByType(type: trackType)
            
        self.audioSession.type = self.trackType!
        
        
        
        SuggestedAudioRouting.presentSuggestedAudioViewController(fromVC: self, trackType: self.trackType, trackArray: self.currentAudioArray)
    }
    
    func collectionView(_ collectionView: UICollectionView,
          layout collectionViewLayout: UICollectionViewLayout,
          sizeForItemAt indexPath: IndexPath) -> CGSize {
         
        return CGSize(width: 80, height: 80)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.currentAudioArray = []
    }
    
}
