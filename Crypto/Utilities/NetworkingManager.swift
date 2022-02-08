//
//  NetworkingManager.swift
//  Crypto
//
//  Created by shehan karunarathna on 2022-02-05.
//

import Foundation
import Combine

class NetworkingManager{
    
    enum NetWorkingError: LocalizedError{
        case badURLResponse(url:URL)
        case unkown
        var errorDescription: String?{
            switch self {
            case .badURLResponse(url: let url): return "[🔥]Bad response from URL\(url)"
                
            case .unkown: return "[⚠️]Unknown error occured"
                
            }
        }
    }
    
    static func fetchCoins(url: URL) -> AnyPublisher<Data, Error>{
         URLSession.shared.dataTaskPublisher(for: url)
//            .subscribe(on: DispatchQueue.global(qos: .default))
            .tryMap { output in
                try handleURLResponse(output: output, url: url)
            }
            .retry(3)
//            .receive(on:DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    static func handleURLResponse(output: URLSession.DataTaskPublisher.Output, url :URL)throws -> Data{
        guard let response = output.response as? HTTPURLResponse,
              response.statusCode >= 200 && response.statusCode < 300 else {
                  throw NetWorkingError.badURLResponse(url: url)
                  
              }
        return output.data
    }
    
    static func handleCompletion(completion: Subscribers.Completion<Error>){
        switch completion {
        case .finished :
            break
        case .failure(let error) :
            print(error.localizedDescription)
        }
    }
}
