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

    enum Error: Swift.Error
    {
        case unknownAPIResponse
        case generic
    }

    /**
     Creates URL for user
     */
    public static func coursesURL(for department:String) -> URL?
    {
        guard let escapedTerm = department.addingPercentEncoding(withAllowedCharacters: CharacterSet.alphanumerics) else {
            return nil
        }
        let urlString = "https://raw.githubusercontent.com/hsswx7/wustlCourses/master/\(escapedTerm).json"
        return URL(string:urlString)
    }
    
    /// For now simply uses the JSON object we have to populate the @CourseData
    public static func getCourses(completion: @escaping (Result<Department>) -> Void)
    {

        /// Tries to get the search URL and produces an error if url cannot be created
        guard let departmentURL = coursesURL(for: "COMPUTER SCIENCE AND ENGINEERING-E81") else
        {
            completion(Result.error(Error.unknownAPIResponse))
            return
        }

        /// Creates and initializes a URLRequest with the given URL and cache policy.
        let request = URLRequest(url: departmentURL)

        // Creating a task to retrieve data
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error
            {
                DispatchQueue.main.async {
                    completion(Result.error(error))
                }
                return
            }

            guard
                /// I know I will get a HTTPURLResponse back
                /// URLResponse: Whenever you make an HTTP request, the URLResponse object you get back is actually an instance of the `HTTPURLResponse` class.
                let _ = response as? HTTPURLResponse,
                /// Settings the data
                let data = data
                // Return error if response and data cant be set
                else {
                    DispatchQueue.main.async {
                        completion(Result.error(Error.unknownAPIResponse))
                    }
                    return
                }

            do
            {
                // Used
                // https://www.youtube.com/watch?v=YY3bTxgxWss
                let apiResult = try JSONDecoder().decode(Department.self, from: data)

                DispatchQueue.main.async {
                    completion(Result.results(apiResult))
                }
            }
            catch
            {
                completion(Result.error(error))
                return
            }
        }.resume()
    }
}
