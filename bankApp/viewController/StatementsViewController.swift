//
//  StatementsViewController.swift
//  bankApp
//
//  Created by Raphael Oliveira Chagas on 13/09/19.
//  Copyright © 2019 Raphael Oliveira Chagas. All rights reserved.
//

import UIKit

class StatementsViewController: UIViewController {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var exitButton: UIButton!
    @IBOutlet weak var accountLabel: UILabel!
    @IBOutlet weak var balanceLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var accountStack: UIStackView!
    @IBOutlet weak var balanceStack: UIStackView!
    
    let statementsIndentifier = "StatementsTableViewCell"
    let statementsHeaderIndentifier = "HeaderTableViewCell"
    
    var statements: Statements?
    var dateUser: UserAccount?
    
    @IBAction func exitButtonClick(_ sender: UIButton) {
        self.buildAlert()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.isNavigationBarHidden = true
        self.tableView.tableFooterView = UIView()
        accountLabel.text = "\(dateUser?.bankAccount ?? "") / \(dateUser?.agency ?? "")"
        nameLabel.text = dateUser?.name
        balanceLabel.text = ToolBox.shared.makeBRFormat(valor: dateUser?.balance ?? 0)
        self.setAccessibility()
    }
    
    func setAccessibility() {
        self.accountStack.isAccessibilityElement = true
        self.accountStack.accessibilityLabel = "Conta \(self.accountLabel.text ?? "")"
        self.balanceStack.isAccessibilityElement = true
        self.balanceStack.accessibilityLabel = "Saldo \(self.balanceLabel.text ?? "")"
        self.accessibilityElements = [self.nameLabel, self.exitButton, self.accountStack, self.balanceStack, self.tableView]
    }
    
    func buildAlert() {
        
        let alert = UIAlertController(title: "Sair", message: "Deseja realmente sair?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Sim", style: .default, handler: { (_) in
            self.navigationController?.popViewController(animated: true)
        }))
        
        alert.addAction(UIAlertAction(title: "Não", style: .cancel, handler: nil))
    
        self.present(alert, animated: true)
    }
}

extension StatementsViewController: UITableViewDelegate {
    
}

extension StatementsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 55
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        tableView.register(UINib(nibName: self.statementsHeaderIndentifier, bundle: Bundle.main), forCellReuseIdentifier: self.statementsHeaderIndentifier)
        guard let cell = tableView.dequeueReusableCell(withIdentifier: self.statementsHeaderIndentifier) as? HeaderTableViewCell else { fatalError() }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return statements?.statementList.count ?? 0
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        tableView.register(UINib(nibName: self.statementsIndentifier, bundle: Bundle.main), forCellReuseIdentifier: self.statementsIndentifier)
        guard let cell = tableView.dequeueReusableCell(withIdentifier: self.statementsIndentifier, for: indexPath) as? StatementsTableViewCell else { fatalError() }
        let statement = statements?.statementList[indexPath.row]
        
        cell.titleLabel.text = statement?.title
        cell.dateLabel.text = statement?.date
        cell.descriptionLabel.text = statement?.desc
        cell.valueLabel.text = ToolBox.shared.makeBRFormat(valor: statement?.value ?? 0)
        cell.setRounded()
        cell.setAccessibility()
        
        return cell
    }
}
