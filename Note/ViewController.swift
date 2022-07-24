//
//  ViewController.swift
//  Note
//
//  Created by Константин Малков on 27.05.2022.
// Objectives : Create Note, Edit Note, Save in cache ,edit text, paste photo(as possible)

import UIKit


class ViewController: UIViewController, UITableViewDelegate,UITableViewDataSource {
 
    
    @IBOutlet var table: UITableView!
    @IBOutlet var textLabel: UILabel!
    
    let defaultcolor = CGColor(red: 220, green: 195, blue: 87, alpha: 0.5)
    
    var models: [(title: String, note: String)] = []
    
    var textModels: [(title: String, note: String)] = [(title: "Check", note: "Subtitle"),(title: "Check", note: "Subtitle"),(title: "Check", note: "Subtitle")]
    
    var navigationBar: UINavigationBar = {
        var bar = UINavigationBar()
        bar.setBackgroundImage(UIImage(), for: .default)
        bar.shadowImage = UIImage()
        bar.isTranslucent = true
        bar.barTintColor = .clear
        
        return bar
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Notes"
        table.isHidden = false
        table.delegate = self
        table.dataSource = self
        table.reloadData()
        view.addSubview(navigationBar)
        emptyTable()
    }

    @IBAction func slider(_ sender: UISlider)  {
        let value = CGFloat(sender.value)
        textLabel.font = UIFont(name: "Times New Roman", size: value)
    }
    
    @IBAction func didTapToSetting(){
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "setting") as? SettingViewController else {
            return
        }
        vc.title = "Change font size"
        navigationItem.largeTitleDisplayMode = .never
        vc.changeFontSize = { font in
            self.navigationController?.popViewController(animated: true)
            
        }
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func didTapButton () {
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "new") as? EnterViewController else {
            return
        }
        vc.title = "New note"
        navigationItem.largeTitleDisplayMode = .never
        //берем данные из EnterViewController
        vc.completion = {  noteTitle, note in
            self.navigationController?.popViewController(animated: true)
            self.models.append((title: noteTitle, note: note))
            self.textLabel.isHidden = true
            self.table.isHidden = false
            self.table.reloadData()
        }
        navigationController?.pushViewController(vc, animated: true )
    }
    
    func emptyTable (){
        //условия отображения таблицы или лейбла
    }
    //MARK: - TableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return models.count
        return models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell",for: indexPath)
        cell.textLabel?.text = models[indexPath.row].title
        cell.detailTextLabel?.text = models[indexPath.row].note 
        cell.detailTextLabel?.font = UIFont(name: "Times New Roman", size: 24)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let model = models[indexPath.row]
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "note") as? NoteViewController else {
            return
        }
        vc.title = "Note"
        vc.navigationItem.largeTitleDisplayMode = .never
        vc.noteTitle = model.title
        vc.note = model.note
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
//работа со свайпами
    //neseccasry for iOS 13 and below
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .none
    }
    //func work principle like UIAlertController/swipes right
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let trash = UIContextualAction(style: .normal, title: "Trash") { [weak self] (action, view, completionHandler) in
            self?.models.remove(at: indexPath.row)
            self?.table.deleteRows(at: [indexPath], with: .fade)
            completionHandler(true)
        }
        trash.backgroundColor = .systemRed

        let unread = UIContextualAction(style: .normal, title: "Mark as Unread") { [weak self] action, view, completionHandler in
            self?.table.cellForRow(at: indexPath)?.backgroundColor = .systemGray2
            completionHandler(true)
        }
        unread.backgroundColor = .systemIndigo
        //запихнуть в левый свайп
        let readed = UIContextualAction(style: .normal, title: "Mark as Readed") { [weak self] action, view, completionHandler in
            self?.table.cellForRow(at: indexPath)?.backgroundColor = .systemPink
            completionHandler(true)
        }
        
        let configuration = UISwipeActionsConfiguration(actions: [trash,unread,readed])
        return configuration
    }
    //add swipes motion from left
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action = UIContextualAction(style: .normal, title: "Favourite") { [weak self] action, view, completionHandler in
            self?.table.deselectRow(at: indexPath, animated: true)
            completionHandler(true)
        }
        action.backgroundColor = .systemMint
        return UISwipeActionsConfiguration(actions: [action])
    }
}

