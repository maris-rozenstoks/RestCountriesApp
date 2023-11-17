//
//  CountryDetailsViewController.swift
//  RestCountriesApp
//
//  Created by maris.rozenstoks on 17/11/2023.
//

import UIKit

class CountryDetailsViewController: UIViewController {
    
    var country: Country?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView() {
        view.backgroundColor = UIColor(red: 0.89, green: 0.96, blue: 0.84, alpha: 1.0)
        title = "Selected country"
        
        let nameLabel = UILabel()
        let capitalLabel = UILabel()
        let populationLabel = UILabel()
        
        if let selectedCountry = country {
            let commonName = selectedCountry.name.common ?? ""
            let attributedString = NSMutableAttributedString(string: "Common name:\n\(commonName)")
            attributedString.addAttribute(.font, value: UIFont.boldSystemFont(ofSize: 24), range: NSRange(location: 0, length: 12))
            nameLabel.attributedText = attributedString
            nameLabel.textColor = UIColor.label
            nameLabel.numberOfLines = 2
            nameLabel.textAlignment = .left
            nameLabel.frame = CGRect(x: 20, y: 140, width: view.frame.width - 40, height: 60)
            nameLabel.sizeToFit()
            

            
            if let capitalArray = selectedCountry.capital, !capitalArray.isEmpty {
                let capitals = capitalArray.joined(separator: ", ")
                capitalLabel.text = "Capital: \(capitals)"
            } else {
                capitalLabel.text = "Capital: N/A"
            }
            capitalLabel.textColor = UIColor.darkGreen
            capitalLabel.frame = CGRect(x: 20, y: 200, width: view.frame.width - 40, height: 80)
            
            populationLabel.text = "Population: \(selectedCountry.population)"
            populationLabel.textColor = UIColor.darkGreen
            populationLabel.frame = CGRect(x: 20, y: 260, width: view.frame.width - 40, height: 40)
        }
        
        view.addSubview(nameLabel)
        view.addSubview(capitalLabel)
        view.addSubview(populationLabel)
    }
}

extension UIColor {
    static let darkGreen = UIColor(red: 0.0, green: 0.3, blue: 0.0, alpha: 1.0)
}
