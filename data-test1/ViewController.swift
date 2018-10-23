//
//  ViewController.swift
//  data-test1
//
//  Created by dit on 2018. 10. 23..
//  Copyright © 2018년 dit. All rights reserved.
//

import UIKit

class ViewController: UIViewController, XMLParserDelegate, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var myTableView: UITableView!
    var myBookData = [BookData]()
    var BTitle = ""
    var BAuthor = ""
    var currentElement = ""
    // 배열 선언
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //xml 파일 소문자 대문자 확실히 인지.
        if let path = Bundle.main.url(forResource: "book", withExtension: "xml") {
            if let myParser = XMLParser(contentsOf: path) {
                myParser.delegate = self
                myTableView.delegate = self
                myTableView.dataSource = self
                if myParser.parse() {
                    print("Parsing succeed")
                    for i in 0 ..< myBookData.count {
                        print(myBookData[i].title)
                        print(myBookData[i].author)
                    }
                } else {
                    print("Parsing failed")
                }
            } else {
                print("path failed")
            }
        } else {
            print("file error")
        }
    }
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        currentElement = elementName
        print(currentElement)
    }
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        //공백 제거하기
        let data = string.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        //빈칸 아니면 출력
        if !data.isEmpty {
            switch currentElement {
            case "title" : BTitle = data
            case "author" : BAuthor = data
            default : break
            }
        }
    }
    
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if elementName == "book" {
            let myItem = BookData()
            myItem.title = BTitle
            myItem.author = BAuthor
            myBookData.append(myItem)
            
            //myitem에 내용 추가
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myBookData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let myCell = myTableView.dequeueReusableCell(withIdentifier: "RE", for: indexPath)
        myCell.textLabel?.text = myBookData[indexPath.row].title
        myCell.detailTextLabel?.text = myBookData[indexPath.row].author
        
        //서브타이틀을 이용한 데이터 출력
        
        
        
        //태그를 이용한 데이터 출력
//        let CTitle = myCell.viewWithTag(1) as! UILabel
//        let CAuthor = myCell.viewWithTag(2) as! UILabel
//        CTitle.text = myBookData[indexPath.row].title
//        CAuthor.text = myBookData[indexPath.row].author
        
        return myCell
    }
    
}
