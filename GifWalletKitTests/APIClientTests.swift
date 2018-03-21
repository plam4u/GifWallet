//
//  Created by Pierluigi Cifani on 02/03/2018.
//  Copyright © 2018 Code Crafters. All rights reserved.
//

import XCTest
@testable import GifWalletKit

/// Full-suite tests are courtesy of our good friends of HTTPBin

private enum HTTPBINHosts: Environment {
    case production
    case development

    fileprivate var baseURL: URL {
        switch self {
        case .production:
            return URL(string: "https://httpbin.org")!
        case .development:
            return URL(string: "https://dev.httpbin.org")!
        }
    }
}

private enum HTTPBINAPI: Endpoint {
    case ip
    case orderPizza

    var path: String {
        switch self {
        case .orderPizza:
            return "/forms/post"
        case .ip:
            return "/ip"
        }
    }

    var method: HTTPMethod {
        switch self {
        case .orderPizza:
            return .POST
        default:
            return .GET
        }
    }
}

class HTTPBINAPITests: XCTestCase {
    func testIPEndpoint() {
        let getIP = HTTPBINAPI.ip
        XCTAssert(getIP.path == "/ip")
        XCTAssert(getIP.method == .GET)
    }
}

class APIClientTests: XCTestCase {

    var apiClient: APIClient!

    override func setUp() {
        super.setUp()
        apiClient = APIClient(environment: HTTPBINHosts.production)
    }

    func testGET() {
        apiClient.performRequest(forEndpoint: HTTPBINAPI.ip)
    }
}
