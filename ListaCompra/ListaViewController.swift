//
//  ViewController.swift
//  ListaCompra
//
//  Created by Otto Colomina Pardo on 21/1/18.
//  Copyright © 2018 Universidad de Alicante. All rights reserved.
//

import UIKit
import ReSwift

class ListaViewController: UITableViewController, StoreSubscriber {
    typealias StoreSubscriberStateType = AppState
    
    var lista = ListaCompra()
    var listaDataSource = ListaCompraDataSource()
    
    func newState(state: AppState) {
        print("Leyendo")
        listaDataSource.setLista(state.lista)
        self.tableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
       store.subscribe(self)
    }

    override func viewWillDisappear(_ animated: Bool) {
       store.unsubscribe(self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        lista = RepositorioLista().leerLista()
        print("Lista leida...\(Date())")
        listaDataSource.setLista(lista)
        self.tableView.dataSource = listaDataSource
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let celda = tableView.cellForRow(at: indexPath),
           let prioridad = Prioridad(rawValue:indexPath.section) {
            if let estado = lista.switchItemStatus(pos: indexPath.row, prioridad: prioridad) {
                celda.accessoryType = estado ? .checkmark : .none
            }
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func unwind(segue: UIStoryboardSegue) {
        
    }
}

