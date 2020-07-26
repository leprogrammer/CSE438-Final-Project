//
//  getData.swift
//  CSE438_FinalProject
//
//  Created by Harprabh Sangha on 7/22/20.
//  Copyright © 2020 Tejas Prasad. All rights reserved.
//

import Foundation

enum Result<ResultType>
{
    case results(ResultType)
    case error(Error)
}

/// Singleton to get data
class GetData
{
    static let shared = GetData()

    private init()
    {
        // Set up API instance
    }

    /**
     Creates URL for user
     */
    private func coursesURL(for department:String, page:Int) -> URL?
    {

        let urlString = "https://raw.githubusercontent.com/hsswx7/wustlCourses/master/\(department)"
        return URL(string:urlString)
    }
    
    /// For now simply uses the JSON object we have to populate the @CourseData
    public static func getCourses(completion: @escaping (Result<Department>) -> Void)
    {

        let url = Bundle.main.url(forResource: "classes", withExtension: "json")!
        do {
            let jsonData = try Data(contentsOf: url)

            // Used
            // https://www.youtube.com/watch?v=YY3bTxgxWss
            let apiResult = try JSONDecoder().decode(Department.self, from: jsonData)

            DispatchQueue.main.async {
                completion(Result.results(apiResult))
            }
        }
        catch
        {
            completion(Result.error(error))
            return
        }
    }
}
