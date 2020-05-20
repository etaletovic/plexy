//
//  File.swift
//  
//
//  Created by Emir Taletovic on 5/13/20.
//

import Foundation
import Alamofire

public extension Part {
    func download(token: String = "", to: URL, _ progress: @escaping (Int) -> Void) {

        let authToken = token.isEmpty ? plexy.token : token

        let sourceUrl = "\(plexy.baseUrl):\(plexy.port)\(self.key)?download=1"

        let headers: HTTPHeaders = [
            .accept("application/json"),
            .init(name: "X-Plex-Token", value: authToken)
        ]

        let destination: DownloadRequest.Destination = { _, _ in
            let destinationFileUrl = to

            return (destinationFileUrl, [.removePreviousFile, .createIntermediateDirectories])
        }

        AF.download(sourceUrl, headers: headers, to: destination)
            .downloadProgress { p in

                if p.fractionCompleted >= 1 { return }

                progress(Int(p.fractionCompleted * 100))

            }
            .response { response in
                debugPrint(response)
                progress(100)
        }
    }
}
