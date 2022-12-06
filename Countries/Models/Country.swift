//
//  Country.swift
//  Countries
//
//  Created by Chandrachudh K on 23/11/22.
//

import Foundation

// MARK: - Country
struct Country: Codable {
    let name: Name
    let independent: Bool
    let status: String
    let unMember: Bool
    let currencies: [String: Currency]
    let capital: [String]
    let region, subregion: String
    let languages: [String: String]
    let borders: [String]?
    let flag: String
    let maps: Maps
    let population: Int
    let timezones: [String]
    let flags, coatOfArms: ImageInfo
    let idd: PhoneCode
    let car: Car
}

// MARK: - Currency
struct Currency: Codable {
    let name, symbol: String
}

// MARK: - PhoneCode
struct PhoneCode: Codable {
    let root: String
    let suffixes: [String]
}

// MARK: - CoatOfArms
struct ImageInfo: Codable {
    let png: String?
    let svg: String?
}

// MARK: - Car
struct Car: Codable {
    let side: String
}

// MARK: - Maps
struct Maps: Codable {
    let googleMaps, openStreetMaps: String
}

// MARK: - Name
struct Name: Codable {
    let common, official: String
}

typealias Countries = [Country]
