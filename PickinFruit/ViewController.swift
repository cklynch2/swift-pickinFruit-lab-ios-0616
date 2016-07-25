//
//  ViewController.swift
//  PickinFruit
//
//  Created by Flatiron School on 7/17/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var spinButton: UIButton!
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var fruitPicker: UIPickerView!
    
    var fruitsArray = ["🍎", "🍊", "🍌", "🍐", "🍇", "🍉", "🍓", "🍒", "🍍"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.fruitPicker.accessibilityLabel = Constants.FRUIT_PICKER
        self.spinButton.accessibilityLabel = Constants.SPIN_BUTTON
        
        fruitPicker.dataSource = self
        fruitPicker.delegate = self
        
    }
    
    @IBAction func spinButtonTapped(sender: UIButton) {
        let randomRowOne = Int(arc4random_uniform(UInt32(fruitsArray.count)))
        let randomRowTwo = Int(arc4random_uniform(UInt32(fruitsArray.count)))
        let randomRowThree = Int(arc4random_uniform(UInt32(fruitsArray.count)))
        
        fruitPicker.selectRow(randomRowOne, inComponent:0, animated:true)
        fruitPicker.selectRow(randomRowTwo, inComponent:1, animated:true)
        fruitPicker.selectRow(randomRowThree, inComponent:2, animated:true)
        
        let fruitOne = fruitsArray[fruitPicker.selectedRowInComponent(0)]
        let fruitTwo = fruitsArray[fruitPicker.selectedRowInComponent(1)]
        let fruitThree = fruitsArray[fruitPicker.selectedRowInComponent(2)]
        
        if fruitOne == fruitTwo && fruitTwo == fruitThree {
            resultLabel.text = "WINNER!"
        } else {
            resultLabel.text = "TRY AGAIN"
        }
        animateResultLabel()
    }
    
    func animateResultLabel() {
        resultLabel.alpha = 0
        
        UIView.animateWithDuration(0.3, delay: 0.0, options: UIViewAnimationOptions.Repeat, animations: {
            UIView.setAnimationRepeatCount(3)
            self.resultLabel.alpha = 1
            
            }) { (true) in
                self.resultLabel.alpha = 0
        }
    }
    
    // MARK - Picker View Implementation
    
    // The number of columns of data
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 3
    }
    
    // The number of rows of data
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return fruitsArray.count
    }
    
    // The data to return for the row and component (column) that's being passed in
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return fruitsArray[row]
    }


}


// MARK: Set Up
extension ViewController {
    
    override func viewDidLayoutSubviews() {
        if self.spinButton.layer.cornerRadius == 0.0 {
            configureButton()
        }
    }
    
    func configureButton()
    {
        self.spinButton.layer.cornerRadius = 0.5 * self.spinButton.bounds.size.width
        self.spinButton.layer.borderColor = UIColor.whiteColor().CGColor
        self.spinButton.layer.borderWidth = 4.0
        self.spinButton.clipsToBounds = true
    }
    
}



