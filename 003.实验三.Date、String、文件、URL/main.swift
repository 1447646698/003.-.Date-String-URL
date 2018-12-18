//
//  main.swift
//  003.实验三.Date、String、文件、URL
//
//  Created by student on 2018/12/15.
//  Copyright © 2018年 李潘. All rights reserved.
//

import Foundation
//1.显示当前准确的中文时间，包括北京、东京、纽约、伦敦，格式为（2016年9月28日星期三 上午10:25）
let nowDate = Date()

var dateFormatter = DateFormatter()
dateFormatter.dateFormat = "yyyy年M月dd日  EEEE aa hh:mm"
dateFormatter.locale = Locale.current

dateFormatter.timeZone = TimeZone(abbreviation: "UTC+8:00")
let BeiJingDate = dateFormatter.string(from: nowDate)
print("北京时间：\(BeiJingDate)")

dateFormatter.timeZone = TimeZone(abbreviation: "UTC+9:00")
let TokyoDate = dateFormatter.string(from:nowDate)
print("东京时间：\(TokyoDate)")

dateFormatter.timeZone = TimeZone(abbreviation: "UTC-5:00")
let NewyorkDate = dateFormatter.string(from:nowDate)
print("纽约时间：\(NewyorkDate)")

dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
let LondonDate = dateFormatter.string(from:nowDate)
print("伦敦时间：\(LondonDate)")
/*2.处理字符串
 *a)新建字符串:"Swift is a powerful and intuitive programming language for iOS, OS X, tvOS, and watchOS."
 *b)返回字符串从第6个字符到第20个字符的子串；
 *c)删除其中所有的OS字符；
 */
let aStr = "Swift is a powerful and intuitive programming language for iOS, OS X, tvOS, and watchOS."

let subString = aStr.replacingOccurrences(of: "OS", with: "")  //用""来替换子串，相当于删除
print("删除OS后的字符串:\(subString)")


let dateaStrDic = [["date":BeiJingDate],["date":TokyoDate],["date":NewyorkDate],["date":LondonDate],["初始串":aStr],["删除OS后的字符串":subString]] as AnyObject
//3.将1、2题的时间和字符串存入一个字典中，并存入沙盒中的Document某文件中；
let defaultPath = FileManager.default
var url = defaultPath.urls(for: .documentDirectory, in: .userDomainMask).first!
url.appendPathComponent("dateaStrDic.txt")
dateaStrDic.write(toFile:url.path,atomically:true)
print("1、2题沙盒中的Document文件路径：\(url.path)")
let a = NSDictionary(contentsOf: url)
//通过指定的url获取图片，并转换为二进制数据
let picture = try Data(contentsOf: URL(string: "https://ss0.bdstatic.com/5aV1bjqh_Q23odCf/static/superman/img/logo/bd_logo1_31bdc765.png")!)
//将转换后的二进制数据存储为png图片
if var url = defaultPath.urls(for: .documentDirectory, in: .userDomainMask).first {
    url.appendPathComponent("image.png")
    try picture.write(to: url)
}


// 图片保存
//图片的路径
let urlPicture = URL(string: "https://ss3.bdstatic.com/70cFv8Sh_Q1YnxGkpoWK1HF6hhy/it/u=3534289497,3677101726&fm=27&gp=0.jpg")!
//将json转换为二进制数据
let dataPicturee = try Data(contentsOf: url)
//序列化json
let json = try JSONSerialization.jsonObject(with: dataPicturee, options: .allowFragments)
//解析json数据
if let dic = json as? [String: Any] {
    if let weather = dic["weatherinfo"] as? [String: Any] {
        let city = weather["city"]!
        let temp = weather["temp"]!
        let wd = weather["WD"]!
        let ws = weather["WS"]!
        print("城市: \(city), 温度: \(temp), 风向: \(wd), 风力: \(ws)")
        
    }
}


