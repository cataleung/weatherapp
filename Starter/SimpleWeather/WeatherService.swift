//
//  WeatherService.swift
//  SimpleWeather
//
//  Created by Simon Ng on 1/11/2016.
//  Copyright © 2016 AppCoda. All rights reserved.
//

import Foundation

class WeatherService {
    private static let APIID = "5dbb5c068718ea452732e5681ceaa0c7"
    
    /**
     Get weather information including both temperature and weather condition by using OpenWeatherMap's free API.
     
     Sample usage:
     
     ```
     WeatherService.getWeatherInfo("Hong Kong") { (temperature, weatherCondition) in
     // Perform UI update
     }
     ```
     
     - Parameter city: The name of the city to lookup
     - Parameter completionHandler: The block of code to execute after the weather information is returned
     
     - Returns: No return value
     
     */
    static func getWeatherInfo(city: String, completionHandler: @escaping (_ temperature: String, _ weatherCondition: String) -> Void) {
        
        let weatherAPI = "http://api.openweathermap.org/data/2.5/weather?q=" + city.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)! + "&appid=" + APIID + "&units=metric"
        
        print(weatherAPI)
        
        if let url = URL(string: weatherAPI) {
            let session = URLSession.shared
            let dataTask = session.dataTask(with: url, completionHandler: { (data, response, error) -> Void in
                
                guard let data = data else {
                    return
                }
                
                var currentTemperature = "N/A"
                var currentWeatherCondition = "NA"
                
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                    
                    // Parse the current temperature
                    if let main = json["main"] as? [String: Any],
                        let temperature = main["temp"] as? Int {
                        currentTemperature = "\(temperature)"
                    }
                    
                    // Parse the weather condition
                    if let weather = json["weather"] as? [[String: Any]],
                        let weatherCondition = weather[0]["main"] as? String {
                        print(weatherCondition)
                        currentWeatherCondition = weatherCondition
                    }
                } catch {
                    print("Failed to get weather data!")
                }
                
                completionHandler(currentTemperature, currentWeatherCondition)
            })
            
            dataTask.resume()
        }
    }
    
    
}
