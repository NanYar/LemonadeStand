//
//  ViewController.swift
//  LemonadeStand
//
//  Created by NanYar on 30.10.14.
//  Copyright (c) 2014 NanYar. All rights reserved.
//

import UIKit


class ViewController: UIViewController
{
    @IBOutlet weak var moneySupplyCount: UILabel!
    @IBOutlet weak var lemonSupplyCount: UILabel!
    @IBOutlet weak var iceCubeSupplyCount: UILabel!
    @IBOutlet weak var lemonPurchaseCount: UILabel!
    @IBOutlet weak var iceCubePurchaseCount: UILabel!
    @IBOutlet weak var lemonMixCount: UILabel!
    @IBOutlet weak var iceCubeMixCount: UILabel!
    
    var supplies = Supplies(aMoney: 10, aLemons: 1, aIceCubes: 1)
    let price = Price()
    
    var lemonsToPurchase = 0
    var iceCubsToPurchase = 0
    var lemonsToMix = 0
    var iceCubsToMix = 0
    
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    
    
    
    // IBActions
    @IBAction func purchaseLemonButtonPressed(sender: UIButton)
    {
    }
    
    @IBAction func purchaseIceCubeButtonPressed(sender: UIButton)
    {
    }

    @IBAction func unpurchaseLemonButtonPressed(sender: UIButton)
    {
    }

    @IBAction func unpurchaseIceCubeButtonPressed(sender: UIButton)
    {
    }
    
    
    @IBAction func mixLemonButtonPressed(sender: UIButton)
    {
    }
    
    @IBAction func mixIceCubeButtonPressed(sender: UIButton)
    {
    }
    
    @IBAction func unmixLemonButtonPressed(sender: UIButton)
    {
    }
    
    @IBAction func unmixIceCubeButtonPressed(sender: UIButton)
    {
    }
    
    
    @IBAction func startDayButtonPressed(sender: UIButton)
    {
    }
    
    
    
    // Helper Functions
    
    func updateMainView()
    {
        moneySupplyCount.text = "$\(supplies.money)"
        lemonSupplyCount.text = "\(supplies.lemons) Lemons"
        iceCubeSupplyCount.text = "\(supplies.iceCubes) Ice Cubes"
        
        lemonPurchaseCount.text = String(lemonsToPurchase)
        iceCubePurchaseCount.text = String(iceCubsToPurchase)
        
        lemonMixCount.text = String(lemonsToMix)
        iceCubeMixCount.text = String(iceCubsToMix)
    }
}
