//
//  File.swift
//  
//
//  Created by Emir Taletovic on 5/13/20.
//

import Foundation
import Alamofire

public extension Part {
    func download(token: String = "", saveTo: URL, _ progress: @escaping (Int) -> Void) {

        let authToken = token.isEmpty ? Plexy.Auth.token : token

        let sourceUrl = "\(Plexy.baseUrl):\(Plexy.port)\(self.key)?download=1"

        let headers: HTTPHeaders = [
            .accept("application/json"),
            .init(name: "X-Plex-Token", value: authToken)
        ]

        let destination: DownloadRequest.Destination = { _, _ in
            let destinationFileUrl = saveTo

            return (destinationFileUrl, [.removePreviousFile, .createIntermediateDirectories])
        }

        AF.download(sourceUrl, headers: headers, to: destination)
            .downloadProgress { prog in

                if prog.fractionCompleted >= 1 { return }

                progress(Int(prog.fractionCompleted * 100))

            }
            .response { response in
                debugPrint(response)
                progress(100)
        }
    }
}
