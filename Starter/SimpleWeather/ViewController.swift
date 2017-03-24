//
//  ViewController.swift
//  MyWeather
//
//  Created by Catalina Leung on 11/3/2017.
//  Copyright © 2017 Catalina Leung. All rights reserved.
//

import UIKit
import ImagePicker

class ViewController: UIViewController, ImagePickerDelegate {
    
    @IBOutlet var temperatureLabel: UILabel!
    @IBOutlet var cityLabel: UILabel!
    @IBOutlet var weatherImageView: UIImageView!
    @IBOutlet var backgroundImageView: UIImageView!
    @IBOutlet var messageLabel: UILabel!
    
    var defaultCity = "New York"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cityLabel.text = defaultCity
        backgroundImageView.image=UIImage(named:defaultCity)
        
        WeatherService.getWeatherInfo(city:defaultCity ){(temperature, weatherCondition) in
            OperationQueue.main.addOperation{
                self.temperatureLabel.text = temperature
                self.weatherImageView.image = UIImage(named: weatherCondition)
            }
        }
        messageLabel.text="It's cloudy today\nNo worries\nYou can still go for a hike."
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func unwindToMainView(segue: UIStoryboardSegue){
        if let selectedCity = segue.identifier {
            cityLabel.text=selectedCity
            backgroundImageView.image = UIImage(named:selectedCity)
            WeatherService.getWeatherInfo(city:selectedCity){(temperature, weatherCondition) in
                OperationQueue.main.addOperation{
                    self.temperatureLabel.text = temperature
                    self.weatherImageView.image = UIImage(named: weatherCondition)
                }
                
            }
            dismiss(animated:true, completion: nil)
        }
    }
    @IBAction func showCamera(_sender:Any) {
        let imagePickerController = ImagePickerController()
        imagePickerController.delegate = self
        present(imagePickerController, animated: true, completion:nil)
    }
    

    func doneButtonDidPress(_ imagePicker: ImagePickerController, images:[UIImage]){
        backgroundImageView.image = images[0]
        dismiss(animated:true, completion:nil)
    }
    
    func wrapperDidPress(_ imagePicker: ImagePickerController, images: [UIImage]) {}
    
    
    func cancelButtonDidPress(_ imagePicker: ImagePickerController) {
         self.dismiss(animated:true, completion: nil)
    }
    
}



