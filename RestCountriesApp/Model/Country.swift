//
//  Country.swift
//  RestCountriesApp
//
//  Created by maris.rozenstoks on 17/11/2023.
//

import Foundation


struct Name:Codable{
    let common,official:String?


}

struct Country:Codable{
    let name:Name
    let capital:[String]?
    let population:Int
}



