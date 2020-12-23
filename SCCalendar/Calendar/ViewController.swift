//
//  ViewController.swift
//  SCCalendar
//
//  Created by WaQing on 2020/12/15.
//

import UIKit
import FloatingPanel
import SwiftHEXColors
import SwiftDate

class ViewController: UIViewController, FloatingPanelControllerDelegate {

    //
    
    
    
    var fpc: FloatingPanelController!
    
    var dataSource: YearInfo?
    
    lazy var appearance: SurfaceAppearance = {
        let appearance = SurfaceAppearance()
        let shadow = SurfaceAppearance.Shadow()
        shadow.color = UIColor.black
        shadow.offset = CGSize(width: 0, height: 16)
        shadow.radius = 16
        shadow.spread = 8
        appearance.shadows = [shadow]
        appearance.cornerRadius = 30.0
        
        return appearance
    }()

    lazy var contentVC: ContentViewController = {
        let sb = UIStoryboard(name: "Main", bundle: .main)
        if let contentVC = sb.instantiateViewController(identifier: "ContentViewController")
            as? ContentViewController {
            return contentVC
        }
        return UIViewController() as! ContentViewController
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 上拉 日历
        setupFPC()
        readJsonFile()
    }
    
    func setupFPC() {
        // Initialize a `FloatingPanelController` object.
        fpc = FloatingPanelController()

        fpc.delegate = self // Optional
        fpc.layout = MyFloatingPanelLayout()
        
        fpc.set(contentViewController: self.contentVC)

        // Track a scroll view(or the siblings) in the content view controller.
//        fpc.track(scrollView: contentVC.tableView)

        fpc.surfaceView.appearance = appearance
        
        fpc.surfaceView.grabberHandle.barColor = UIColor(hex: 0x00615B) ?? .white
        
        // Add and show the views managed by the `FloatingPanelController` object to self.view.
        fpc.addPanel(toParent: self)
    }
    
    // 选择日期
    func didSelect(date:Date) {
        let dayInfo = dataSource?.getDayInfoWith(date: date + 1.days)
        
    }
    
    // MARK: 读取JSON
    func readJsonFile(fileName name:String = "2021")  {
        
        guard let path = Bundle.main.path(forResource: name, ofType: "json") else { return }
        
        let localData = NSData.init(contentsOfFile: path)! as Data
        
        do {
            // banner即为我们要转化的目标model
            let banner = try JSONDecoder().decode(YearInfo.self, from: localData)
            self.dataSource = banner
        } catch {
            debugPrint("banner===ERROR")
        }
        
    }

}


class MyFloatingPanelLayout: FloatingPanelLayout {
    let position: FloatingPanelPosition = .bottom
    let initialState: FloatingPanelState = .tip
    var anchors: [FloatingPanelState: FloatingPanelLayoutAnchoring] {
        return [
            .half: FloatingPanelLayoutAnchor(fractionalInset: 0.5, edge: .bottom, referenceGuide: .safeArea),
            .tip: FloatingPanelLayoutAnchor(absoluteInset: 44.0, edge: .bottom, referenceGuide: .safeArea),
        ]
    }
}
