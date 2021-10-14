//
//  GameViewController.swift
//  Mind Match Game
//
//  Created by Drew Brokamp on 2/11/19.
//  Copyright © 2019 Drew Brokamp. All rights reserved.
//

import UIKit
import SpriteKit
import GameKit
import GoogleMobileAds


class GameViewController: UIViewController, GADFullScreenContentDelegate {
    
    var interstitial: GADInterstitialAd!
    var bannerViewBottom: GADBannerView!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let view = self.view as! SKView? {
            

            
            // Load the SKScene from 'GameScene.sks'
            let scene = GameScene(size: view.bounds.size)
            
            // Set the scale mode to scale to fit the window
            scene.scaleMode = .aspectFill
            
            // Present the scene
            view.presentScene(scene)
            
            view.ignoresSiblingOrder = true
            view.allowsTransparency = true
            view.backgroundColor = .clear
            
            
            //Create and Load adMob Ads
            createAndLoadInterstitial()
            bannerViewBottom = createAndLoadBannerAd()
            bannerViewBottom.load(GADRequest())
            
            //Create notifcations for ads
            NotificationCenter.default.addObserver(self, selector: #selector(showInterstitial), name: .showInterstitialAd, object: nil)
            
            NotificationCenter.default.addObserver(self, selector: #selector(showBannerAd), name: .showBannerAd, object: nil)
            
            NotificationCenter.default.addObserver(self, selector: #selector(wonGame), name: .wonGame, object: nil)
            
            
        }
        
        GameCenterHelper.helper.viewController = self
        
    }
    
    @objc func wonGame() {
        let alert = UIAlertController(title: "Game Won", message: "Impressive Memory! Resetting game to level 1.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
        NSLog("The \"OK\" alert occured.")
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    
    func createAndLoadBannerAd() -> GADBannerView {
        
        let banner = GADBannerView(adSize: GADAdSizeBanner)
  
        banner.adUnitID = kBannerAdUnitID
        banner.rootViewController = self
        return banner
    }
    
    func addBannerViewToView(_ bannerView: GADBannerView) {
        bannerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(bannerView)
        view.addConstraints(
            [NSLayoutConstraint(item: bannerView,
                                attribute: .bottom,
                                relatedBy: .equal,
                                toItem: view,
                                attribute: .bottomMargin,
                                multiplier: 1,
                                constant: 0),
             NSLayoutConstraint(item: bannerView,
                                attribute: .centerX,
                                relatedBy: .equal,
                                toItem: view,
                                attribute: .centerX,
                                multiplier: 1,
                                constant: 0)
            ])
        
    }
    
    @objc func showBannerAd() {
  
        addBannerViewToView(bannerViewBottom)
        
        
    }
    
    @objc func hideBannerAd() {
        bannerViewBottom.removeFromSuperview()
    }
    
    //MARK: Interstitial Ads
    func createAndLoadInterstitial() {
        
        let request = GADRequest()
            GADInterstitialAd.load(
              withAdUnitID: kIntersitialAdUnitID, request: request
            ) { (ad, error) in
              if let error = error {
                print("Failed to load interstitial ad with error: \(error.localizedDescription)")
                return
              }
              self.interstitial = ad
              self.interstitial?.fullScreenContentDelegate = self
            }
        
    }
    
    @objc func showInterstitial() {
        
        if interstitial != nil {
            interstitial.present(fromRootViewController: self)
        } else {
            print("Ad wasn't ready")
        }
        
    }
    
    func interstitialDidDismissScreen(_ ad: GADInterstitialAd) {
        createAndLoadInterstitial()
    }
    
    override var shouldAutorotate: Bool {
        return true
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
}
