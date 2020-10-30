//
//  ViewController.swift
//  DesafioAlertController
//
//  Created by Luciana on 29/10/20.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var tableViewMarket: UITableView!
    
    var arrayMarket = [Market]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewMarket.delegate = self
        tableViewMarket.dataSource = self
        
        imageView.image = UIImage(named: "market1.webp")
        
        arrayMarket.append(Market(name: "Sabão", quantity: 2))
        arrayMarket.append(Market(name: "Açucar", quantity: 2))
        arrayMarket.append(Market(name: "Sal", quantity: 1))
        arrayMarket.append(Market(name: "Feijão", quantity: 2))
        arrayMarket.append(Market(name: "Macarrão", quantity: 3))
        arrayMarket.append(Market(name: "Detergente", quantity: 5))
        arrayMarket.append(Market(name: "Pipoca", quantity: 5))
    }
    
    @IBAction func actionButtonAddItem(_ sender: Any) {
        showAlert(nil)
    }
    
    
    func showAlert(_ item: Market?) {
        let alertAddItem = UIAlertController(title: "Atenção",
                                             message: "Adicione o item",
                                             preferredStyle: .alert)
        
        
        alertAddItem.addTextField(configurationHandler: {textFieldName in
            textFieldName.placeholder = "Insira o nome do item"
            textFieldName.tag = 1
            textFieldName.text = item?.name
            
        })
        
        alertAddItem.addTextField(configurationHandler: {textFieldQuantity in
            textFieldQuantity.placeholder = "Insira a quantidade"
            textFieldQuantity.tag = 2
            textFieldQuantity.text = item?.quantity != nil ? String(item!.quantity): nil
        })
        
        
        let buttonCancel = UIAlertAction(title: "Cancel", style: .default, handler: nil)
        let buttonAdd = UIAlertAction(title: item != nil ? "Salvar" : "OK", style: .default) { _ in
            
            guard let nameField = (alertAddItem.view.viewWithTag(1) as? UITextField) else {
                return
            }
            guard let qtdField = (alertAddItem.view.viewWithTag(2) as? UITextField) else {
                return
            }
            
            if let name = nameField.text, let quantity = Int(qtdField.text!) {
                if let editItem = item {
                    editItem.name = name
                    editItem.quantity = quantity
                    self.editItem(item: editItem)
                } else {
                    self.addItem(item: Market(name: name, quantity: quantity))
                }
            }
            
        }

        alertAddItem.addAction(buttonCancel)
        alertAddItem.addAction(buttonAdd)
        present(alertAddItem, animated: true, completion: nil)
    }
    
    //FUNÇAO PARA O ACTIONSHEET
    
    func alertTableView(item: Market) {

    let alert = UIAlertController(title: "Atenção",
                                       message: "Escolha uma opção",
                                       preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Editar", style: .default, handler: { (action) in
            self.showAlert(item)
        }))
        
        alert.addAction(UIAlertAction(title: "Excluir", style: .cancel, handler: { (action) in
            self.deleteItem(item: item)
        }))
        
        alert.addAction(UIAlertAction(title: "Cancelar", style: .default, handler: nil))
        
        present(alert, animated: true, completion: nil)
    }
//
    
    
    //FUNÇÃO PARA ADICIONAR ITENS NO ARRAY
    func addItem (item: Market) {
            arrayMarket.append(item)
            tableViewMarket.reloadData()
    }
    
    //FUNÇÃO PARA DELETAR ITENS DO ARRAY
    func deleteItem (item: Market) {
        if !arrayMarket.isEmpty {
            //if itemExist(searchItem: item) {
                arrayMarket.removeAll() {$0.name.lowercased() == item.name.lowercased()}
                tableViewMarket.reloadData()
            //}
        }
    }
    
    //PEGAR O ITEM NO ARRAY PARA EDIÇÃO
    func editItem (item: Market) {
        let itemReceive = arrayMarket.first() {$0.name.lowercased() == item.name.lowercased()}
        itemReceive!.quantity = item.quantity
        tableViewMarket.reloadData()
    }
    
    //Função para validar se o item existe na lista
    func itemExist (searchItem: Market) -> Bool{
        var itemExist = false
        for item in arrayMarket {
            if item.name == searchItem.name {
            itemExist = true
            }
        }
        return itemExist
    }


}
extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = arrayMarket[indexPath.row]
        alertTableView(item: item)
    }
    
}
extension ViewController: UITableViewDataSource {
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayMarket.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellItem = tableView.dequeueReusableCell(withIdentifier: "MarketCell", for: indexPath) as! MarketCell
        cellItem.setup(item: arrayMarket[indexPath.row])
        return cellItem
    }
    
}

