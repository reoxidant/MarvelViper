//
//  MarvelAPI.swift
//  MarvelViper
//
//  Created by Виталий Шаповалов on 04.01.2022.
//

import SwiftHash

enum API: String {
    case baseUrl = "https://gateway.marvel.com/v1/public"
    case publicKey = "4f7515a4be7e9670228c968ccb5bc6a4"
    case privateKey = "0846645ca18187f3a424dbb471cf73ff59f3eaee"
}

struct MarvelAPI {
    
    static let shared = MarvelAPI()
    
    func getCreditals() -> String {
        let ts = String(Date().timeIntervalSince1970)
        let hash = MD5(ts + API.privateKey.rawValue + API.publicKey.rawValue).lowercased()
        
        return "ts=\(ts)&apikey=\(API.publicKey.rawValue)&hash=\(hash)"
    }
    
    func getCharactersURL(page: Int = 0, limit: Int = 50) -> String {
        let offset = page * limit
        return API.baseUrl.rawValue + "/characters?offset=\(offset)&limit=\(limit)&" + getCreditals()
    }
    
    func getFullURLBy(resourceURI: String) -> String {
        resourceURI + "?" + getCreditals()
    }
}
