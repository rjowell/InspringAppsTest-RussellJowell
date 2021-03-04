//
//  ViewController.swift
//  InspriingAppsTest
//
//  Created by Russell Jowell on 3/2/21.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var loadingWindow: UIView!
    @IBOutlet weak var dataViewer: UITableView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("Count is "+String(sequenceTally.count))
        return sequenceTally.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let currentCell = dataViewer.dequeueReusableCell(withIdentifier: "cellTemplate") as! PageOccurenceCell
        
        currentCell.pageOne.text = sequenceTally.sorted(by: {$0.value > $1.value})[indexPath.row].key.split(separator: " ")[0].replacingOccurrences(of: " ", with: "")
        currentCell.pageTwo.text = sequenceTally.sorted(by: {$0.value > $1.value})[indexPath.row].key.split(separator: " ")[1].replacingOccurrences(of: " ", with: "")
        currentCell.pageThree.text = sequenceTally.sorted(by: {$0.value > $1.value})[indexPath.row].key.split(separator: " ")[2].replacingOccurrences(of: " ", with: "")
        
        currentCell.countLabel.text = String(sequenceTally.sorted(by: {$0.value > $1.value})[indexPath.row].value)
        
        
        
        return currentCell
    }
    

    
    
    
    var sequenceTally: [String:Int] = [:]
   
    var sortedNumbers: [String:Int] = [:]
    var userCount: [String:[String]]=[:]
    //var counter: Int = 0
    func processResponse(responseString: String)
    {
        let lines = responseString.components(separatedBy: "\n")
        let ipStartIndex = lines[0].index(lines[0].startIndex,offsetBy: 0)
        let ipEndIndex = lines[0].index(lines[0].startIndex,offsetBy: 9)
        let pageStartIndex = lines[0].index(lines[0].startIndex,offsetBy: 48)
        let ipRange: Range = ipStartIndex..<ipEndIndex
        for line in lines
        {
            guard let hIndex = line.firstIndex(of: "H") else{return }
            let pageRange = pageStartIndex..<hIndex
           
            if(userCount[String(line[ipRange])] == nil)
            {
                userCount[String(line[ipRange])] = []
            }
            if(userCount[String(line[ipRange])]?.count == 3)
            {
                var stringKey: String = ""
              
                for items in userCount[String(line[ipRange])]!
                {
                    stringKey.append(items + " ")
                }
            
                if(sequenceTally[stringKey] == nil)
                {
                    sequenceTally[stringKey] = 0
                }
                
               
                sequenceTally[stringKey]! += 1
                
                userCount[String(line[ipRange])] = []
                
                
            }
            userCount[String(line[ipRange])]?.append(String(line[pageRange]).replacingOccurrences(of: " ", with: ""))
           
        }
        
      
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        let url = URL(string: "https://files.inspiringapps.com/IAChallenge/30E02AAA-B947-4D4B-8FB6-9C57C43872A9/Apache.log")!
       
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            self.processResponse(responseString: String(data: data!, encoding: String.Encoding.utf8)!)
            
            DispatchQueue.main.async {
                print(self.sequenceTally.count)
                self.dataViewer.delegate = self
                self.dataViewer.dataSource = self
                self.dataViewer.reloadData()
                self.loadingWindow.isHidden = true
            }
            
        }.resume()
        
  
        
        
        
        
        
    }
    
    
    

}

