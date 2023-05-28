//
//  OpenAIService.swift
//  PersonalAI
//
//  Created by ryananda on 09/04/23.
//

import Foundation
import Alamofire

class openAIService {
    let baseURL = "https://api.openai.com/v1/completions"
    
    func sendMessage(message: String) {
        let body = OpenAICompletionBody(model: "text-davinci-003", prompt: message, temperature: 0.7 )
        let headers: HTTPHeaders = [
            "Authorization" : "Bearer \(Constants.openAIAPIKey)"
        ]
        AF.request(baseURL + "completions", method: .post, parameters: body, encoder: .json, headers: headers).response {
            data in print(data)
        }
    }
}

struct OpenAICompletionBody: Encodable {
    let model: String
    let prompt: String
    let temperature: Float?
}
