//
//  Globals.swift
//  Memory+Concentration
//
//  Created by Drew Brokamp on 10/29/20.
//

import SpriteKit

let kBannerAdUnitID: String = "ca-app-pub-4493503969826620/2321437662"
let kIntersitialAdUnitID: String = "ca-app-pub-4493503969826620/7164335697"
let kTestBannerAdUnitID: String = "ca-app-pub-3940256099942544/2934735716"
let kTestInterstitialAdUnitID: String = "ca-app-pub-3940256099942544/4411468910"

extension Notification.Name {
    static let newGameSetupComplete = Notification.Name("newGameSetupComplete")
    static let memorizeCounterComplete = Notification.Name("memorizeCounterComplete")
    static let pauseGame = Notification.Name("pauseGame")
    static let showInterstitialAd = Notification.Name("showInterstitialAd")
    static let showBannerAd = Notification.Name("showBannerAd")
    static let hideBannerAd = Notification.Name("hideBannerAd")
    static let stackCardsComplete = Notification.Name("stackCardsComplete")
    static let wonGame = Notification.Name("wonGame")

}

enum SymbolConfigurations {
    static let configuration = UIImage.SymbolConfiguration(pointSize: 23.0, weight: .semibold)
}

enum Slides {
    case first, second, third, fourth, complete
}

enum ViewZPositions {    
    static let background: CGFloat = 1.0
    static let cards: CGFloat = 2.0
    static let symbols: CGFloat = 2.5
    static let hud: CGFloat = 3.0
    static let hudBackground: CGFloat = 5.0
    static let hudObject: CGFloat = 6.0
    static let hudBox: CGFloat = 7.0
    static let hudLabel: CGFloat = 8.0
    
    static let firstRunHud: CGFloat = 10.0
    static let firstRunHudBackground: CGFloat = 11.0
    static let firstRunHudLabel: CGFloat = 12.0
    
}

enum FontSizes {
    static let hudLabel: CGFloat = 17.0
    static let button: CGFloat = 17.0
}

