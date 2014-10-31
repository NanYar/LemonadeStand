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
    
    var weatherArray: [[Int]] = [[-10, -9, -5, -7], [5, 8, 10, 9], [22, 25, 27, 23]]
    var weatherToday = [0, 0, 0, 0]
    var weatherImageView = UIImageView(frame: CGRect(x: 30, y: 57, width: 50, height: 50))
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.view.addSubview(weatherImageView)
        simulateWeatherToday()
        updateMainView()
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    
    
    
    // IBActions
    @IBAction func purchaseLemonButtonPressed(sender: UIButton)
    {
        if supplies.money >= price.lemon
        {
            lemonsToPurchase += 1
            supplies.lemons += 1
            supplies.money -= price.lemon
            updateMainView()
        }
        else
        {
            showAlertWithText(message: "You don't have enough money to buy lemons")
        }
    }
    
    @IBAction func purchaseIceCubeButtonPressed(sender: UIButton)
    {
        if supplies.money >= price.iceCube
        {
            iceCubsToPurchase += 1
            supplies.iceCubes += 1
            supplies.money -= price.iceCube
            updateMainView()
        }
        else
        {
            showAlertWithText(message: "You don't have enough money to buy ice cubes")
        }
    }

    @IBAction func unpurchaseLemonButtonPressed(sender: UIButton)
    {
        if lemonsToPurchase > 0
        {
            lemonsToPurchase -= 1
            supplies.lemons -= 1
            supplies.money += price.lemon
            updateMainView()
        }
        else
        {
            showAlertWithText(message: "You don't have lemmons to return")
        }
    }

    @IBAction func unpurchaseIceCubeButtonPressed(sender: UIButton)
    {
        if iceCubsToPurchase > 0
        {
            iceCubsToPurchase -= 1
            supplies.iceCubes -= 1
            supplies.money += price.iceCube
            updateMainView()
        }
        else
        {
            showAlertWithText(message: "You don't have ice cubes to return")
        }
    }
    
    
    @IBAction func mixLemonButtonPressed(sender: UIButton)
    {
        if supplies.lemons > 0
        {
            lemonsToPurchase = 0 // lock the user from purchasing
            lemonsToMix += 1
            supplies.lemons -= 1
            updateMainView()
        }
        else
        {
            showAlertWithText(message: "You don't have lemons to mix")
        }
    }
    
    @IBAction func mixIceCubeButtonPressed(sender: UIButton)
    {
        if supplies.iceCubes > 0
        {
            iceCubsToPurchase = 0 // lock the user from purchasing
            iceCubsToMix += 1
            supplies.iceCubes -= 1
            updateMainView()
        }
        else
        {
            showAlertWithText(message: "You don't have ice cubs to mix")
        }
    }
    
    @IBAction func unmixLemonButtonPressed(sender: UIButton)
    {
        if lemonsToMix > 0
        {
            lemonsToPurchase = 0 // lock the user from purchasing
            lemonsToMix -= 1
            supplies.lemons += 1
            updateMainView()
        }
        else
        {
            showAlertWithText(message: "You don't have lemons to unmix")
        }
    }
    
    @IBAction func unmixIceCubeButtonPressed(sender: UIButton)
    {
        if iceCubsToMix > 0
        {
            iceCubsToPurchase = 0 // lock the user from purchasing
            iceCubsToMix -= 1
            supplies.iceCubes += 1
            updateMainView()
        }
        else
        {
            showAlertWithText(message: "You don't have ice cubs to unmix")
        }
    }
    
    
    @IBAction func startDayButtonPressed(sender: UIButton)
    {
        if lemonsToMix == 0 || iceCubsToMix == 0
        {
            showAlertWithText(message: "You need to add at least 1 Lemon and 1 Ice Cube")
        }
        else
        {
            let average = findAverage(weatherToday)
            println("weatherToday: \(weatherToday)")
            println("average: \(average)")
            
            let customers = Int(arc4random_uniform(UInt32(abs(average)))) // abs = wandelt negativ zu positiv
            println("customers: \(customers)")

            let lemonadeRatio = Double(lemonsToMix) / Double(iceCubsToMix)
            println("lemonadeRatio: \(lemonadeRatio)")
            
            for x in 0..<customers
            {
                let preference = Double(arc4random_uniform(UInt32(101))) / 100
                println("preference: \(preference)")
                
                if preference < 0.4 && lemonadeRatio > 1 // bevorzugen mehr sauer
                {
                    supplies.money += 1
                    println("Paid: bevorzugen mehr sauer")
                }
                else if preference > 0.6 && lemonadeRatio < 1 // bevorzugen mehr verduennt
                {
                    supplies.money += 1
                    println("Paid: bevorzugen mehr verduennt")
                }
                else if preference <= 0.6 && preference >= 0.4 && lemonadeRatio == 1 // bevorzugen mehr gleich
                {
                    supplies.money += 1
                    println("Paid: bevorzugen mehr gleich")
                }
                else
                {
                    println("No match, No Revenue")
                }
             }
            lemonsToPurchase = 0
            iceCubsToPurchase = 0
            lemonsToMix = 0
            iceCubsToMix = 0
            
            simulateWeatherToday()
            updateMainView()
        }
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
    
    
    func showAlertWithText(header: String = "Warning", message: String)
    {
        var alert = UIAlertController(title: header, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    
    func simulateWeatherToday()
    {
        let randomNumber = Int(arc4random_uniform(UInt32(weatherArray.count))) // = 0 - 2
        weatherToday = weatherArray[randomNumber]
        
        switch randomNumber
        {
            case 0: weatherImageView.image = UIImage(named: "Cold")
            case 1: weatherImageView.image = UIImage(named: "Mild")
            default: weatherImageView.image = UIImage(named: "Warm")
        }
    }
    
    
    func findAverage(data: [Int]) -> Int
    {
        var sum = 0
        for number in data
        {
            sum += number
        }
        var average = Double(sum) / Double(data.count)
        var averageRounded = Int(ceil(average)) // = rundet nach oben auf
        return averageRounded
    }
}
