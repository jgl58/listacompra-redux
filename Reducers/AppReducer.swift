//
//  AppResucer.swift
//  ListaCompra
//
//  Created by Jonay Gilabert López on 30/01/2020.
//  Copyright © 2020 Otto Colomina Pardo. All rights reserved.
//

import ReSwift

func appReducer(action: Action, state: AppState?) -> AppState {
    //si no hay estado, lo inicializamos
    let state = state ?? AppState(lista: ListaCompra())

    switch action {
        case let action as AddItem:
            state.lista.addItem(action.nuevo)
        default:
            break
    }

    return state
}
