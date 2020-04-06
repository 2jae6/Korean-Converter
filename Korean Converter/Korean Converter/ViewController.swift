//
//  ViewController.swift
//  Korean Converter
//
//  Created by 1 on 2020/02/24.
//  Copyright © 2020 wook. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //텍스트뷰 둥글게
        BeforeText.layer.cornerRadius = 10
        AfterText.layer.cornerRadius = 10
        
        //텍스트뷰 테두리
        self.BeforeText.layer.borderWidth = 1.0
        self.BeforeText.layer.borderColor = UIColor.black.cgColor
        
        self.AfterText.layer.borderWidth = 1.0
        self.AfterText.layer.borderColor = UIColor.black.cgColor
        
        //버튼 테두리
        beforeDeleteButton.layer.cornerRadius = 0.5 * beforeDeleteButton.bounds.size.height
        afterDeleteButton.layer.cornerRadius = 0.5 * afterDeleteButton.bounds.size.height
        convertButton.layer.cornerRadius = 0.5 * convertButton.bounds.size.height
        afterCopyButton.layer.cornerRadius = 0.5 * afterCopyButton.bounds.size.height
        
        //스위치 색상 바꾸기
        MixSwitchOutlet.onTintColor = .systemYellow
        MixSwitchOutlet.tintColor = .systemYellow
        LowSwitchOutlet.onTintColor = .systemYellow
        LowSwitchOutlet.tintColor = .systemYellow
        YaminSwitchOutlet.onTintColor = .systemYellow
        YaminSwitchOutlet.tintColor = .systemYellow
        DoubleSwitchOutlet.onTintColor = .systemYellow
        DoubleSwitchOutlet.tintColor = .systemYellow
        
        
        
    }
    //Mark: Switch
    @IBOutlet weak var MixSwitchOutlet: UISwitch!
    @IBOutlet weak var YaminSwitchOutlet: UISwitch!
    @IBOutlet weak var LowSwitchOutlet: UISwitch!
    @IBOutlet weak var DoubleSwitchOutlet: UISwitch!
    
    @IBAction func MixSwitch(_ sender: Any) {
        
    }
    
    @IBAction func YaminSwitch(_ sender: Any) {
    }
    
    
    @IBAction func LowSwitch(_ sender: Any) {
    }
    
    
    @IBAction func DoubleSwitch(_ sender: Any) {
    }
    
    
    
    //Mark: Text
    @IBOutlet weak var BeforeText: UITextView!
    @IBOutlet weak var AfterText: UITextView!
    
    
    //Mark: Button
    @IBOutlet weak var beforeDeleteButton: UIButton!
    @IBOutlet weak var afterDeleteButton: UIButton!
    @IBOutlet weak var convertButton: UIButton!
    @IBOutlet weak var afterCopyButton: UIButton!
    
    
    @IBAction func ConvertButton(_ sender: Any) {
        //키보드 내리기
        self.view.endEditing(true)
        
        var resultText: String
        
        resultText = BeforeText.text
        
        
        
        
        if MixSwitchOutlet.isOn == true{
            var imsi1: String = ""
            let sliceBox:[String] = resultText.components(separatedBy: " ")
            
            for i in 0 ... sliceBox.count - 1{
                
                imsi1 = imsi1 + " " + mixString(str: sliceBox[i])
            }
            resultText = imsi1
        }
        
        
        
        
        if YaminSwitchOutlet.isOn == true{
            var imsi2: String = ""
            for i in 0 ... resultText.count - 1{
                imsi2 = imsi2 + yaminChange(text: "\(resultText[resultText.index(resultText.startIndex, offsetBy: i)])")
            }
            resultText = imsi2
            
        }
        
        
        
        if LowSwitchOutlet.isOn == true{
            var imsi3: String = ""
            for i in 0 ... resultText.count - 1{
                
                imsi3 = imsi3 + checkJongsung(text: "\(resultText[resultText.index(resultText.startIndex, offsetBy: i)])")
                
                
            }
            resultText = imsi3
        }
        
        
        
        if DoubleSwitchOutlet.isOn == true{
            var imsi4: String = ""
            for i in 0 ... resultText.count - 1{
                
                imsi4 = imsi4 + checkChosung(text: "\(resultText[resultText.index(resultText.startIndex, offsetBy: i)])")
                
                
            }
            resultText = imsi4
        }
        
        AfterText.text = resultText
    }
    
    @IBAction func CopyButton(_ sender: Any) {
        UIPasteboard.general.string = AfterText.text
        let alert = UIAlertController(title: "성공", message: "클립보드로 복사 완료!", preferredStyle: UIAlertController.Style.alert)
        
        let okAction = UIAlertAction(title: "OK", style: .default) { (action) in
            
        }
        alert.addAction(okAction)
        present(alert, animated: false, completion: nil)
    }
    
    
    
    @IBAction func BeforeDeleteButton(_ sender: Any) {
        BeforeText.text = ""
    }
    @IBAction func AfterDeleteButton(_ sender: Any) {
        AfterText.text = ""
    }
    
    
    //Mark: Custom Method
    //섞기
    func mixString(str: String) -> String{
        
        
        if str.count < 4{
            return str
        }
        
        //숫자나 특수문자 들어있으면 반환
        //한글자씩 쪼개보기
        for i in 0 ... str.count - 1{
            var imsi0:Character
            imsi0 = str[str.index(str.startIndex, offsetBy: i)]
            let val = UnicodeScalar(String(imsi0))?.value
            guard let value = val else {
                print("요쯤")
                return  str
                
            }
            if  (value < 0xAC00 || value > 0xD7A3) {
                print("조쯤")
                return str
            }   // 한글아니면 반환띠
            
            
        }
        
        
        
        var first:[String] = []
        first.append(String(str.first!))
        
        var last:[String] = []
        last.append(String(str.last!))
        
        
        var mid:[String] = []
        let start = str.index(after: str.startIndex)
        let end = str.index(str.endIndex, offsetBy: -2)
        let subString = str[start...end]
        for i in 0 ... subString.count - 1{
            mid.append("\(subString[subString.index(subString.startIndex, offsetBy: i)])")
        }
        
        let result = first + shuffleBoy(str: mid) + last
        print(result)
        let realResult = result.joined()
        print(realResult)
        return realResult
    }
    
    func shuffleBoy(str: Array<String>) -> Array<String>{
        let newStr = str.shuffled()
        
        if newStr == str{
            return shuffleBoy(str: str)
        }else{
            return newStr
        }
    }
    //ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ
    //야민
    //한글자를 3개로 나눠서 그 안에껄 변경
    func yaminChange(text: String)->String{
        switch text {
        case "대":
            return "머"
        case "머":
            return "대"
        case "귀":
            return "커"
        case "커":
            return "귀"
        case "파":
            return "과"
        case "과":
            return "파"
        case "피":
            return "끠"
        case "끠":
            return "피"
        case "비":
            return "네"
        case "네":
            return "비"
        case "며":
            return "댸"
        case "댸":
            return "며"
        case "거":
            return "지"
        case "지":
            return "거"
        case "겨":
            return "저"
        case "저":
            return "겨"
        case "교":
            return "꼬"
        case "꼬":
            return "교"
        case "유":
            return "윾"
        case "우":
            return "윽"
        case "웃":
            return "읏"
        case "을":
            return "울"
        case "왕":
            return "앟"
        case "왱":
            return "앻"
        case "욍":
            return "잏"
        case "왓":
            return "앛"
        case "왯":
            return "앷"
        case "욋":
            return "잋"
            
        default:
            return text
            
        }
    }
    
    
    //받침 추가
    func checkJongsung(text: String) ->String{
        
        let val = UnicodeScalar(String(text))?.value
        guard let value = val else { return  text}
        
        if (value < 0xAC00 || value > 0xD7A3) { return text }   // 한글아니면 반환
        let x =  (value - 0xac00) / 28 / 21
        let y =  ((value - 0xac00) / 28) % 21
        let z =  (value - 0xac00) % 28
        let i =  UnicodeScalar(0x1100 + x)! //초성
        let j =  UnicodeScalar(0x1161 + y)! //중성
        var k =  UnicodeScalar(0x11a6 + 1 + z)! //종성
        
        
        var randNum = arc4random_uniform(27) + 1
        var dnr = UnicodeScalar(0x11a6 + 1 + randNum)
        
        if k == "\u{11A7}"{
            k = dnr!
            return "\(i)\(j)\(k)"
        }else{
            return text
        }
    }
    
    //쌍자음 만들기 초성
    func checkChosung(text: String) -> String{
        let val = UnicodeScalar(String(text))?.value
        guard let value = val else { return  text}
        
        if (value < 0xAC00 || value > 0xD7A3) { return text }   // 한글아니면 반환
        let x =  (value - 0xac00) / 28 / 21
        let y =  ((value - 0xac00) / 28) % 21
        let z =  (value - 0xac00) % 28
        var i =  UnicodeScalar(0x1100 + x)! //초성
        var j =  UnicodeScalar(0x1161 + y)! //중성
        var k =  UnicodeScalar(0x11a6 + 1 + z)! //종성
        
        
        //    var randNum = arc4random_uniform(27) + 1
        //  var dnr = UnicodeScalar(0x11a6 + 1 + randNum)
        switch i {
        case UnicodeScalar(0x1100 + 0): //ㄱ > ㄲ
            i = UnicodeScalar(0x1100 + 1)!
            break
        case UnicodeScalar(0x1100 + 3): //ㄷ > ㄸ
            i = UnicodeScalar(0x1100 + 4)!
            break
        case UnicodeScalar(0x1100 + 7): //ㅂ > ㅃ
            i = UnicodeScalar(0x1100 + 8)!
            break
        case UnicodeScalar(0x1100 + 9): //ㅅ > ㅆ
            i = UnicodeScalar(0x1100 + 10)!
            break
        case UnicodeScalar(0x1100 + 12): //ㅈ > ㅉ
            i = UnicodeScalar(0x1100 + 13)!
            break
        default:
            break
        }
        
        switch k {
        case UnicodeScalar(0x11a6 + 1 + 1): //ㄱ > ㄲ
            k = UnicodeScalar(0x11a6 + 1 + 2)!
            break
        case UnicodeScalar(0x11a6 + 1 + 19): // ㅅ > ㅆ
            k = UnicodeScalar(0x11a6 + 1 + 20)!
            break
        default: break
            
        }
        
        if k == "\u{11A7}"{
            return "\(i)\(j)"
        }else{
            return "\(i)\(j)\(k)"
        }
        
    }
    
    //키보드 내리기
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        self.view.endEditing(true)
    }
}

