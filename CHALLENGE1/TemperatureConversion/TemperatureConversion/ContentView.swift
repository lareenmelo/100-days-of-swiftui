//
//  ContentView.swift
//  TemperatureConversion
//
//  Created by Melo, Lareen on 4/30/21.
//

import SwiftUI

struct ContentView: View {
    @State private var initialTemperature = ""
    @State private var initialUnit = 0
    @State private var conversionUnit = 0
    private let temperatureUnits = ["Celsius", "Fahrenheit", "Kelvin"]
    
    var convertTemperatureToCelsius: Double {
        let temperatureValue = Double(initialTemperature) ?? 0.0
        var unit: UnitTemperature
        
        switch temperatureUnits[initialUnit] {
        case "Fahrenheit":
            unit = UnitTemperature.fahrenheit
        case "Kelvin":
            unit = UnitTemperature.kelvin
        default:
            unit = UnitTemperature.celsius
        }
        
        let temperature = Measurement(value: temperatureValue, unit: unit)
        let temperatureInCelsius = temperature.converted(to: .celsius)
        
        return temperatureInCelsius.value
        
    }
    
    var convertedTemperature: Measurement<UnitTemperature> {
        let temperatureInCelsiusValue = convertTemperatureToCelsius
        var unit: UnitTemperature

        
        switch temperatureUnits[conversionUnit] {
        case "Fahrenheit":
            unit = UnitTemperature.fahrenheit
        case "Kelvin":
            unit = UnitTemperature.kelvin
        default:
            unit = UnitTemperature.celsius
        }
        
        let temperatureInCelsius = Measurement(value: temperatureInCelsiusValue, unit: UnitTemperature.celsius)
        let temperature = temperatureInCelsius.converted(to: unit)
        
        return temperature
        
    }
    
    var message: String {
        let temperature = convertTemperatureToCelsius
        
        if temperature < 20.0 {
            return "Pretty girl winter 🥶"
        } else if temperature >= 20.0 && temperature < 31.0 {
            return "Pretty girl summer 😛"
        } else if temperature >= 31 {
            return "Pretty girl boiling 🥵"
        } else {
            return "🙂"
        }
    }

    var body: some View {
        NavigationView {
            Form {
                Section {
                    Text(message)
                }
                
                Section(header: Text("Tempearture to convert")) {
                    Picker("Select a temperature", selection: $initialUnit) {
                        ForEach(0..<temperatureUnits.count) {
                            Text("\(self.temperatureUnits[$0])")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    
                    TextField("Temperature", text: $initialTemperature)
                }
                
                Section(header: Text("Converted temperature")) {
                    Picker("Select a temperature", selection: $conversionUnit) {
                        ForEach(0..<temperatureUnits.count) {
                            Text("\(self.temperatureUnits[$0])")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    Text("\(convertedTemperature.value, specifier: "%.0f") \(convertedTemperature.unit.symbol)")
                    
                }
            }
            .navigationBarTitle("Pretty Girl Temperature", displayMode: .inline)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
