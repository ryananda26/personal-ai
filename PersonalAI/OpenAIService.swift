//
//  OpenAIService.swift
//  PersonalAI
//
//  Created by ryananda on 09/04/23.
//

import Foundation
import Alamofire
import Combine

class OpenAIService {
    let baseURL = "https://api.openai.com/v1/completions"
    
    func sendMessage(message: String) ->
    AnyPublisher<OpenAICompletionResponse, Error> {
        let body = OpenAICompletionBody(model: "text-davinci-003", prompt: message, temperature: 0.7 )
        let headers: HTTPHeaders = [
            "Authorization" : "Bearer \(Constants.openAIAPIKey)"
        ]
        
        return Future { [weak self] promise in
            guard let self = self else { return }
            
            AF.request(self.baseURL + "completions", method: .post, parameters: body, encoder: .json, headers: headers).responseDecodable(of:OpenAICompletionResponse.self){response in switch response.result {
            case .success(let result):
                promise(.success(result))
            case .failure(let error):
                promise(.failure(error))
            }
            }
        }
        .eraseToAnyPublisher()
    }
    
    struct OpenAICompletionBody: Encodable {
        let model: String
        let prompt: String
        let temperature: Float?
    }
    
    struct OpenAICompletionResponse: Decodable{
        let id: String
        let choices: [OpenAICompletionChoices]
    }
    
    struct OpenAICompletionChoices: Decodable{
        let id: String
    }
}
