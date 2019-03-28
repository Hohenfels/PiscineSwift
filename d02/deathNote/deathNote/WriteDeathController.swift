//
//  WriteDeathController.swift
//  deathNote
//
//  Created by Felicien RENAUD on 1/10/19.
//  Copyright © 2019 Felicien RENAUD. All rights reserved.
//

import UIKit

class WriteDeathController: UIViewController {

    @IBOutlet weak var nameLabel: UITextField!
    @IBOutlet weak var descriptionLabel: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    
    @IBAction func doneButton(_ sender: UIBarButtonItem) {
        if rightDeathFormat()
        {
            let name = nameLabel.text!
            let description = descriptionLabel.text!
            let date = formatDate()
            Death.add(name: name, description: description, date: date)
            print("Name : \(name)\nDescription : \(description)\nAt date : \(date)")
        }
        else
        {
            print("Wrong victim format, returning to main view ...")
        }
        navigationController?.popViewController(animated: true)
    }

    func formatDate() -> String
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy HH:mm"
        return dateFormatter.string(from: datePicker.date)
    }
    
    func rightDeathFormat() -> Bool
    {
        return nameLabel.text != ""
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        datePicker.minimumDate = Date(timeIntervalSinceNow: 0)
        datePicker.date = Date(timeIntervalSinceNow: 2)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
