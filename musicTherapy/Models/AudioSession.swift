//
//  AudioSession.swift
//  musicTherapy
//
//  Created by kkerors on 01.03.2021.
//

import Foundation
import UIKit

struct AudioSession {
    var physicalParams = PhysicalParameters()
    var emotionalParams = EmotionalParameters(moodType: .positive)
    var type = TrackType.black
}

struct  PhysicalParameters {
    var upperPreasure: Int?
    var lowerPreasure: Int?
    var pulse: Int?
}

struct EmotionalParameters {
    var moodType: MoodType
}

enum MoodType: String {
    case positive = "Позитивное"
    case sad = "Грустное"
    case bored = "Cкучающее"
    case inspired = "Вдохновляющее"
    case irritable = "Раздражительное"
    case calm = "Спокойное"
    case funny = "Веселое"
}

enum MoodSong {
    case lyric // лиричная
    case happy // веселая
    case contemplative // созерцательная
}

enum SpeedType {
    case slow
    case normal
    case fast
}
