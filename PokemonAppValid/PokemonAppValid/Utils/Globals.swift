//
//  Globals.swift
//  PokemonAppValid
//
//  Created by Jorge Luis Rivera Ladino on 27/03/20.
//  Copyright © 2020 Jorge Luis Rivera Ladino. All rights reserved.
//

import UIKit

// Typealias

typealias CallServiceHandler = ((_ onSuccess: Bool?, _ onError: Error?) -> Void)?
typealias CallServiceHandlerWithAnyObject = ((_ any: Any?, _ onError: Error?) -> Void)?
typealias AlertActionHandler = ((UIAlertAction) -> Void)?