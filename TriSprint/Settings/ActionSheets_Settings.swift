//
//  ActionSheets_Settings.swift
//  TriSprint
//
//  Created by Nigel Karan on 05.12.21.
//

import SwiftUI

extension SettingsView {
    
    var deleteAccountAction: ActionSheet {
        ActionSheet(title: Text("DELETE YOUR ACCOUNT"), message: Text("Are you sure you want to permanently delete your account?"), buttons: [
            .destructive(Text("Yes 👍🏽"), action: {
                settingsVm.deleteUser()
        
            }),
            .cancel()
        ])
    }
    
    var logoutAction: ActionSheet {
        ActionSheet(title: Text("Logout?"), message: Text("Are you sure?"), buttons: [
            .destructive(Text("Yes 👍🏽"), action: {
                settingsVm.logout()
                loginVm.signedIn = false
            }),
            .cancel()
        ])
    }
    
    var resetPlansAction: ActionSheet {
        
        ActionSheet(title: Text("NOTE: THIS WILL DELETE ALL CURRENT PLANS"), message: Text("Do you want to continue with the reset?"), buttons: [
            .destructive(Text("YES!"), action: {
                if !plans.isEmpty {
                    print("")
                    settingsVm.deletePlans(plans: plans)
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                        plansDeletedConfirmation = true
                    }
                    
                } else {
                    noPlansWarning = true
                }
                showResetPlansWarning = false
            }),
            .default(Text("Oooppss - NO!"),
                     action: {
                         showResetPlansWarning = false
                     })
        ])
            
    }
        
    
    var resetActivitiesAction: ActionSheet {
        ActionSheet(title: Text("NOTE: THIS WILL DELETE ALL YOUR ACTIVITIES"), message: Text("This is permanent. \nDo you want to continue?"), buttons: [
            .destructive(Text("YES!"), action: {
                settingsVm.deleteActivities(swims: swims, rides: rides, runs: runs)
                showResetActivitiesWarning = false
            }),
            .default(Text("Aarrghh - NO!"),
                     action: {
                         showResetActivitiesWarning = false
                     })
        ])
    }
    
    var resetEverythingAction: ActionSheet {
        ActionSheet(title: Text("NOTE: THIS WILL DELETE ALL CURRENT PLANS AND ALL ACTIVITES"), message: Text("This is permanent.\nDo you want to continue?"), buttons: [
            .destructive(Text("YES!"), action: {
                settingsVm.deletePlans(plans: plans)
                settingsVm.deleteActivities(swims: swims, rides: rides, runs: runs)
                showResetEverythingWarning = false
            }),
            .default(Text("Oooppss - NO!"),
                     action: {
                         showResetEverythingWarning = false
                     })
        ])
    }
    
}
