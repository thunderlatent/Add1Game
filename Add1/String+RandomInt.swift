//
//  String+Random.swift
//  Add1
//
//  Created by Jimmy on 2021/4/17.
//

import Foundation
extension String
{
    static func randomInt(lenth: Int) -> String
    {
        var outputString = ""
        for _ in 1...lenth
        {
            let randomNumber = String(Int.random(in: 0...9))
            outputString += randomNumber
        }
        return outputString
    }
    
    func getAnswerForAdd1() -> String
    {
        var answer = ""
        for char in self
        {
            if char == "9"
            {
                answer += "0"
            }else
            {
                if let digitNumber = Int(String(char))
                {
                    answer += String(digitNumber + 1)
                }
            }
        }
        return answer
    }
}
