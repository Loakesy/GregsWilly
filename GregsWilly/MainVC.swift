//
//  MainVC.swift
//  GregsWilly
//
//  Created by Greg Loakes on 4/11/16.
//  Copyright © 2016 Greg Loakes. All rights reserved.
//

import Foundation
import UIKit

class MainVC: UIViewController {
  
  override func viewDidLoad() {
    
    super.viewDidLoad()

    getWeather()
  
  }
  
  fileprivate func getWeather() {
    
    
    let willyWeatherBaseURL = "https://api.willyweather.com.au/v2/"
    let willyWeatherAPIKey = "NTNjN2MxMWY4MDkzMmY1YmVhOTU2ZT"

    let willyLocation = "14158"

    //example info url for Caulfield
    //https://api.willyweather.com.au/v2/NTNjN2MxMWY4MDkzMmY1YmVhOTU2ZT/locations/14158/info.json?platform=iphone&weatherTypes=weather
    
    //https://api.willyweather.com.au/v2/NTNjN2MxMWY4MDkzMmY1YmVhOTU2ZT/locations/14158/weather.json
    
    //https://api.willyweather.com.au/v2/{api key}/locations/1215/weather.json?forecasts=weather,wind&forecastGraphs=temperature,precis&observationalGraphs=pressure,temperature&observational=true&regionPrecis=true&days=1

    
    
    let getLocationsURL = URL(string: "https://api.willyweather.com.au/api/v2/regions.json")!
    
    let weatherRequestURL = URL(string: "\(willyWeatherBaseURL)\(willyWeatherAPIKey)/locations/\(willyLocation)/weather.json?forecasts=weather&")!

    
    var request = URLRequest(url:getLocationsURL)
    request.httpMethod = "GET"
    
    URLSession.shared.dataTask(with:weatherRequestURL, completionHandler: {(data, response, error) in
      if error != nil {
        print("ERROR: \(error)")
      } else {
        do {
          
          let weatherData = try JSONSerialization.jsonObject(
            with: data!,
            options: .mutableContainers) as! [String: AnyObject]
          
          // If we made it to this point, we've successfully converted the
          // JSON-formatted weather data into a Swift dictionary.
          // Let's now used that dictionary to initialize a Weather struct.
          
          //let weather = Weather(weatherData: weatherData)
          
          // Now that we have the Weather struct, let's notify the view controller,
          // which will use it to display the weather to the user.
          
          //self.delegate.didGetWeather(weather)
          
          print("🏫\(weatherData)")
          
          print("🌹Forecasts: \(weatherData["forecasts"]!)")
          
          var forecasts: [String: AnyObject]
          
          forecasts = weatherData["forecasts"] as! [String: AnyObject]
          
          print("🌘\(forecasts)")
          
          let weather = forecasts["weather"] as! [String: AnyObject]
          
          print("☀️Weather: \(weather)")
          
          let days = weather["days"]
          
          print("🌜Days: \(days)")
          
          let arrayDays = days as! Array<Any>
          
          print("😗\(arrayDays[0])")
          
          for forecast in arrayDays {
            
            print("💦\(forecast)")
            
          }
          
          let dayForecast = arrayDays[0] as! [String: AnyObject]
          
          print("💷\(dayForecast["entries"])")
          
          let dayForecastEntriesArray = dayForecast["entries"] as! Array<Any>
          
          print("🌡\(dayForecastEntriesArray[0])")
          
          let dayForecastDict = dayForecastEntriesArray[0] as! [String: AnyObject]
       
          print("🍄\(dayForecastDict["max"])")
          print("🍄\(dayForecastDict["min"])")
          print("🍄\(dayForecastDict["precis"])")

        }
        catch let jsonError as NSError {
          // An error occurred while trying to convert the data into a Swift dictionary.
          print("JSON error description: \(jsonError.description)")
          
          
        }
      }
      
    }).resume()
    
  }
  
}
