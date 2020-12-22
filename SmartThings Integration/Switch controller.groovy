definition(
    name: "Switch Controller for Kratos 2",
    namespace: "Kratos-Controller",
    author: "Leo Babun",
    description: "Allows using the switch based on valid control policies",
    category: "Convenience",
    iconUrl: "https://raw.githubusercontent.com/MichaelStruck/SmartThings/master/IFTTT-SmartApps/App1.png",
    iconX2Url: "https://raw.githubusercontent.com/MichaelStruck/SmartThings/master/IFTTT-SmartApps/App1@2x.png",
    iconX3Url: "https://raw.githubusercontent.com/MichaelStruck/SmartThings/master/IFTTT-SmartApps/App1@2x.png")

preferences {
	section("Input User Email:") {
       input name: "emailUser", type: "email", title: "Email", description: "Enter User Email Address", required: true,
          displayDuringSetup: true
    }   
    
    section("Choose a switch to use:") {
			input "Switch", "capability.switch", title: "Switch", multiple: false, required: true
   		}
}

def installed() {
    atomicState.authorized = false 
    log.debug Switch.getId()
    getPolicyFeedback()
    subscribe(Switch, "switch", "switchHandler")
}

def updated() {
    unsubscribe()
    //Log.debug Switch.getId()
    getPolicyFeedback()
	subscribe(Switch, "Switch", "switchHandler")
}

def switchHandler(evt) {
	getPolicyFeedback()
	log.debug "${atomicState.authorized}"
	if (atomicState.authorized == true){
        if (evt.value == "on") {
            log.debug "${atomicState.authorized} on"
            Switch.on()
        } else {
            log.debug "${atomicState.authorized} off"
            Switch.off()
        }        
    }
}

private def baseUrl() {
    String url = "https://script.google.com/macros/s/AKfycbwIBLyCAAqNeQx3gH_Bvgaz7HvRSav094YhT1hVXPJI-WJMxBk/exec?"                  
    return url
}

def getPolicyFeedback(){
    
    def listPolicies = []
    def listUsers = [] 
    def listDeviceIDs = []
    int counter = 0
        
    def params = [
        uri: "https://spreadsheets.google.com/feeds/list/103c1f4R0JT7MoLXW_OhHKm8dgkqc_FWxmYZnnPhxr4c/3/public/values?alt=json",
    ]

    try {
        httpGet(params) { resp ->
            
            //log.debug "${resp.data}" 
            
            for (object in resp.data.feed.entry){
				listPolicies.add (object.gsx$policyid.$t)  
                listUsers.add (object.gsx$user.$t) 
                listDeviceIDs.add (object.gsx$deviceid.$t) 
            }         
            
            for (user in listUsers){
            	if (user == emailUser){
                	 if (listDeviceIDs[counter] == Switch.getId()){                    
                     	atomicState.authorized = true
                     }
                     else{
                     	atomicState.authorized = false
                     }                     
                }
                else{
                	atomicState.authorized = false
                }
                counter++
            }            
        }       
        
    } catch (e) {
        log.error "something went wrong: $e"
    }
}