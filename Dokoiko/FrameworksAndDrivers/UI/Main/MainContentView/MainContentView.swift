//
//  MainContentView.swift
//  Dokoiko
//
//  Created by 岡崎伸也 on 2021/05/02.
//

import RxCocoa
import RxSwift
import UIKit

/// 表示種別
enum MainContentViewState {
    // エンプティステート（検索履歴なしの場合）
    case empty
    // 検索履歴表示
    case historyList
}

/// メイン画面の履歴画面
class MainContentView: UIView {
    // Cell の高さ（固定）
    let CELL_HEIGHT: CGFloat = 80
    // 画面表示するデータリスト
    var searchList = [SearchResultEntity]()

    @IBOutlet var baseView: UIView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var emptyImageView: UIImageView!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var headerImageView: UIImageView!
    @IBOutlet weak var tableView: UITableView!

    /// コードからの初期化時に呼ばれる
    override init(frame: CGRect) {
        super.init(frame: frame)
        initCustom()
    }

    /// ストーリーボードからの初期化時に呼ばれる
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initCustom()
    }

    /// 画面初期化時に呼ばれる
    private func initCustom() {
        let bundle = Bundle(for: MainContentView.self)
        guard let view = bundle.loadNibNamed("MainContentView", owner: self, options: nil)?.first as? UIView else {
            return
        }
        view.frame = bounds
        addSubview(view)

        baseView.backgroundColor = Asset.backgroundColorPurple.color
        contentView.backgroundColor = Asset.backgroundColorPurple.color
        headerView.backgroundColor = Asset.backgroundColorPurple.color
        tableView.backgroundColor = Asset.backgroundColorPurple.color

        setDisplayMode(state: .empty)

        roundCorners(corners: [.layerMinXMinYCorner, .layerMaxXMinYCorner], radius: 20)
        baseView.roundCorners(corners: [.layerMinXMinYCorner, .layerMaxXMinYCorner], radius: 20)

        let backgroundView = UIView()
        backgroundView.backgroundColor = Asset.backgroundColorPurple.color
        tableView.backgroundView = backgroundView
        tableView.separatorStyle = .none
        tableView.register(UINib(nibName: "MainContentCell", bundle: nil), forCellReuseIdentifier: "MainContentCell")
        tableView.dataSource = self
        tableView.delegate = self
    }

    /// リストを更新する
    func updateContentsList() {
        if searchList.isEmpty {
            setDisplayMode(state: .empty)
            tableView.reloadData()
        } else {
            setDisplayMode(state: .historyList)
        }
    }

    /// 画面表示モード切り替え
    /// - Parameter state: 表示モード
    private func setDisplayMode(state: MainContentViewState) {
        switch state {
        case .empty:
            emptyImageView.isHidden = false
            headerView.isHidden = true
            headerImageView.isHidden = true
            tableView.isHidden = true

        case .historyList:
            emptyImageView.isHidden = true
            headerView.isHidden = false
            headerImageView.isHidden = false
            tableView.isHidden = false
        }
    }
}

extension MainContentView: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        CELL_HEIGHT
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        searchList.count
    }

    // セルの設定
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MainContentCell") as? MainContentCell else {
            return UITableViewCell()
        }
        let result = searchList[indexPath.row]
        let dateUtils = DateUtils()
        var dateStr = ""
        if let date = result.date {
            dateStr = dateUtils.getFormatterStrJP(date: date, formatter: "yyyy年MM月dd日") ?? ""
        }
        cell.setDetails(firstText: result.cityName, subText: dateStr)
        return cell
    }

    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = UIView()
        footerView.backgroundColor = Asset.backgroundColorPurple.color
        return footerView
    }

    func tableView(_ tableView: UITableView, didHighlightRowAt indexPath: IndexPath) {
        print("didHighlightRowAt")
        guard let cell = tableView.cellForRow(at: indexPath) as? MainContentCell else {
            return
        }
        cell.setCellHighlight(hilightState: true)
    }

    func tableView(_ tableView: UITableView, didUnhighlightRowAt indexPath: IndexPath) {
        print("didUnhighlightRowAt")
        guard let cell = tableView.cellForRow(at: indexPath) as? MainContentCell else {
            return
        }
        cell.setCellHighlight(hilightState: false)
    }
}

extension Reactive where Base: MainContentView {
    var searchList: Binder<[SearchResultEntity]> {
        Binder(base) { view, list in
            view.searchList = list
            view.updateContentsList()
        }
    }
}
