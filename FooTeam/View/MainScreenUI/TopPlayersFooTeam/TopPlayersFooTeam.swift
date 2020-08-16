//
//  TopPlayersFooTeam.swift
//  FooTeamUI
//
//  Created by Виталий Сосин on 05.08.2020.
//  Copyright © 2020 Vitalii Sosin. All rights reserved.
//

import SwiftUI

struct TopPlayersFooTeam: View {
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            BoxTopPlayersFooTeam()
        }
    }
}

struct TopPlayersFooTeam_Previews: PreviewProvider {
    static var previews: some View {
        TopPlayersFooTeam()
    }
}
