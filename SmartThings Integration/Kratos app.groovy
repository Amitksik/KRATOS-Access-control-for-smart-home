import groovy.json.JsonSlurper 

definition(
    name: "KRATOS V 1.1",
    namespace: "Smart Home Access Control",
    author: "Amit Sikder and Leo Babun",
    description: "This app provides access control systme for multi-user smart home",
    category: "Safety & Security",
    iconUrl: "http://www.gharexpert.com/mid/4142010105208.jpg",
    iconX2Url: "http://www.gharexpert.com/mid/4142010105208.jpg"
)

preferences {
	page name: "mainPage"
}

def mainPage() {
	dynamicPage(name: "mainPage", title: "", install: true, uninstall: false) {
    preferences{
    section("Input Email:") {
        input name: "emailAdmin", type: "email", title: "Email", description: "Enter Your Email Address", required: true,
          displayDuringSetup: true
    }
    section("Input New User Email:") {
       input name: "emailUser", type: "email", title: "Email", description: "Enter Intended User Email Address", required: false,
          displayDuringSetup: true
    }   
    section("Priority") {
        input "priority_level", "strings", title: "Priority Level of Intended User", required: false
    }
    section("Select Smart Light:") {
		input "Light", "capability.switchLevel", required: false
	    input name: "lightlevel_min", title: "Set Min Brightness (0-100)", type: "number", required: false
        input name: "lightlevel_max", title: "Set Max Brightness (0-100)", type: "number", required: false				  
    }
    section("Select Smart Switch:") {
        input name: "Switch", type: "capability.switch", required: false
        input "restswitchtime_start", "time", title: "Switch Restriction Start Time", required: false
        input "restswitchtime_end", "time", title: "Switch Restriction End Time", required: false
    }
    section([mobileOnly:true], "Instructions") {
			href "pageAbout", title: "About Kratos", description: "Tap to get application version, license and instructions"
        }
    //section("Notifications:") {
        //input "Phone", "Phone", title: "Phone number", required: true
    //}    		
	}
   }
}

page(name: "pageAbout", title: "About Kratos", uninstall: true) {
	
	section("General Purpose") {
		paragraph textHelp1()
	}
    section("Adding New User") {
		paragraph textHelp2()
	}
    section("Creating General Policy") {
		paragraph textHelp3()
	}
    section("Creating Restriction Policy") {
		paragraph textHelp4()
	}
    section("Creating User Policy") {
		paragraph textHelp5()
	}
    
}

include 'asynchttp_v1'
def installed(){
   atomicState.message = [:]   
   
   if (Light){
   		atomicState.policyLight = UUID.randomUUID().toString()
   		EventHandlerSendLight()
   }
   
   if (Switch){
   		atomicState.policySwitch = UUID.randomUUID().toString()
   		EventHandlerSendSwitch()  
   }
   
   if (!Light && !Switch){
   		atomicState.policyLight = UUID.randomUUID().toString()
   		EventHandlerSendLight()
   }
   
   if (Light) {
   		EventHandlerReceiveLight()
   }
   
   if (Switch){
        EventHandlerReceiveSwitch()
   }
   
   if (!Light && !Switch){
   		EventHandlerReceiveLight()
   }
}

def updated(){
   if (Light){
   		atomicState.policyLight = UUID.randomUUID().toString()
   		EventHandlerSendLight()
   }
   
   if (Switch){
   		atomicState.policySwitch = UUID.randomUUID().toString()
   		EventHandlerSendSwitch()  
   }
   
   if (!Light && !Switch){
   		atomicState.policyLight = UUID.randomUUID().toString()
   		EventHandlerSendLight()
   }
   
   if (Light) {
   		EventHandlerReceiveLight()
   }
   
   if (Switch){
        EventHandlerReceiveSwitch()
   }
   
   if (!Light && !Switch){
   		EventHandlerReceiveLight()
   }
}

def uninstalled(){   
}

def EventHandlerSendSwitch(evt) {
    runIn(5, handlerSendSwitch)
}

def EventHandlerSendLight(evt) {
    runIn(5, handlerSendLight)
}

def EventHandlerReceiveLight(evt) {
    runIn(30, handlerReceiveLight)
}

def EventHandlerReceiveSwitch(evt) {
    runIn(30, handlerReceiveSwitch)
}

def handlerSendSwitch() {
    sendSwitchPolicy(emailAdmin, emailUser, priority_level, restswitchtime_start, restswitchtime_end)    
}

def handlerSendLight() {
    sendLightPolicy(emailAdmin, emailUser, priority_level, lightlevel_min, lightlevel_max)    
}

def handlerReceiveSwitch() {
    if (Switch){    
    	getDevicePolicy(Switch.displayName, atomicState.policySwitch) 
    }
    else{
    	getDevicePolicy("null", atomicState.policySwitch)
    }
}

def handlerReceiveLight() {
    if (Light){    
    	getDevicePolicy(Light.displayName, atomicState.policyLight) 
    }
    else{
    	getDevicePolicy("null", atomicState.policyLight)
    }     
}

private def baseUrl() {
    String url = "https://script.google.com/macros/s/AKfycbylX7QJ3Kww2ssw7EJOEzaMdQcKiTYcwhHOmbdtw7rMcy7sbyWK/exec?"
    return url
}

private sendPolicy(policyId, emailAdmin, emailUser, priority_level, deviceid, lightlevel_min, lightlevel_max, restswitchtime_start, restswitchtime_end) {
    def keyId0 = URLEncoder.encode("Kratos")
    def keyId1 = URLEncoder.encode("Policy ID")
    def keyId2 = URLEncoder.encode("Admin Email")
    def keyId3 = URLEncoder.encode("User Email")
    def keyId4 = URLEncoder.encode("Priority")
    def keyId5 = URLEncoder.encode("Device ID")
    def keyId6 = URLEncoder.encode("Brightness Min")
    def keyId7 = URLEncoder.encode("Brightness Max")
    def keyId8 = URLEncoder.encode("Start Time")
    def keyId9 = URLEncoder.encode("End Time")
   
    //log.debug atomicState.policy
    //log.debug emailAdmin.toString()
    //log.debug emailUser.toString()
    //log.debug priority_level.toString()
    //log.debug deviceid.toString()
    //log.debug lightlevel_min.toString()
    //log.debug lightlevel_max.toString()
    //log.debug restswitchtime_start.toString()
    //log.debug restswitchtime_end.toString()
    
    def value0 = URLEncoder.encode("Kratos")
    def value1 = URLEncoder.encode(policyId)
    def value2 = URLEncoder.encode(emailAdmin.toString())
    def value3 = URLEncoder.encode(emailUser.toString())
    def value4 = URLEncoder.encode(priority_level.toString())
    def value5 = URLEncoder.encode(deviceid.toString())
    def value6 = URLEncoder.encode(lightlevel_min.toString())
    def value7 = URLEncoder.encode(lightlevel_max.toString())
    def value8 = URLEncoder.encode(restswitchtime_start.toString())
    def value9 = URLEncoder.encode(restswitchtime_end.toString())
    
    def url = baseUrl() + "${keyId0}=${value0}&" + "${keyId1}=${value1}&" + "${keyId2}=${value2}&" + "${keyId3}=${value3}&" + "${keyId4}=${value4}&" + "${keyId5}=${value5}&" + "${keyId6}=${value6}&" + "${keyId7}=${value7}&" + "${keyId8}=${value8}&" + "${keyId9}=${value9}"
    
    log.debug url
           
    def putParams = [
        uri: url
    ]
    def data = [key1: "this is the response"]
    asynchttp_v1.get('processResponse', putParams) 
    
}

private sendLightPolicy(emailAdmin, emailUser, priority_level, lightlevel_min, lightlevel_max) {

	def deviceid = "null"
    if (Light){    
    	deviceid = Light.getId()
    }        
    sendPolicy(atomicState.policyLight, emailAdmin, emailUser, priority_level, deviceid, lightlevel_min, lightlevel_max, "null", "null")
}


private sendSwitchPolicy(emailAdmin, emailUser, priority_level, restswitchtime_start, restswitchtime_end) {

	def deviceid = "null"
    if (Switch){    
    	deviceid = Switch.getId()
    }
        
    sendPolicy(atomicState.policySwitch, emailAdmin, emailUser, priority_level, deviceid, "null", "null", restswitchtime_start, restswitchtime_end)     
}

def processResponse(response, data) {
    if (response.hasError()) {
        log.error "response has error: $response.errorMessage"
    } else {
        def results
        try {
            // json response already parsed into JSONElement object
            results = response.json
        } catch (e) {
            log.error "error parsing json from response: $e"
        }
        if (results) {
            def total = results?.total_count

            //log.debug "there are $total occurences of httpGet in the Kratos repo"

            // for each item found, log the name of the file
            //results?.items.each { log.debug "httpGet usage found in file $it.name" 
             					  //sendPush("$it.name")}
        } else {
            //log.debug "did not get json results from response body: $response.data"
        }
    }
}

def getPolicyFeedback(policyId){
    
    def listPolicies = []
    def listMessages = [] 
    int counter = 0
        
    def params = [
        uri: "https://spreadsheets.google.com/feeds/list/103c1f4R0JT7MoLXW_OhHKm8dgkqc_FWxmYZnnPhxr4c/2/public/values?alt=json",
    ]

    try {
        httpGet(params) { resp ->
            
            log.debug "${resp.data}" 
            
            for (object in resp.data.feed.entry){
				listMessages.add (object.gsx$message.$t)                               
            }
            
            for (object in resp.data.feed.entry){
				listPolicies.add (object.gsx$policyid.$t)                               
            }
            
            for (policy in listPolicies){
            	if (policy == policyId){
                	 atomicState.message = listMessages[counter]                
                }
                counter++
            }            
        }
    } catch (e) {
        log.error "something went wrong: $e"
    }
}

def getDevicePolicy(deviceType, policyId){
    getPolicyFeedback(policyId)
    if (deviceType != "null"){
    	sendPush("Your policy enrollment/negotiation for device " +  "${deviceType}" + " has resulted in: " + "${atomicState.message}")
	}
    else {
    	sendPush("Your general policy enrollment/negotiation with ID " +  "${policyId}" + " has resulted in: " + "${atomicState.message}")   
	}
}

private def textHelp1() {
	def text =
    	"This application will allow you to implement an access control system in your smart home."
}

private def textHelp2() {
	def text =
    	"Step 1: Input your email as admin email \n" +
        "Step 2: New user email as intended user email \n"+
        "Step 3: Assign priority for new user (the higher number gives lower priority) and save"
}

private def textHelp3() {
	def text =
    	"WARNING: Only Admin can set general policy. \n" +
    	"Step 1: Input admin email \n" +
        "Step 2: Keep blank the user email and priority field \n"+
        "Step 3: Select the device \n "+
        "Step 4: Select the values and save"
}

private def textHelp4() {
	def text =
    	"Restriction policy restricts a specific user  \n" +
    	"Step 1: Input admin email \n" +
        "Step 2: Input target user email as intended user email \n"+
        "Step 3: Input the priority (if the user is not added earlier, otherwise leave it blank \n "+
        "Step 4: Select the device "+
        "Step 5: Leave the values blank and save "
}

private def textHelp5() {
	def text =
    	"User policy allows targeted users to control a device within specific range (time/value)  \n" +
    	"Step 1: Input admin email \n" +
        "Step 2: Input target user email as intended user email \n"+
        "Step 3: Input the priority (if the user is not added earlier, otherwise leave it blank \n "+
        "Step 4: Select the device "+
        "Step 5: Select the permitted range of value/time and save "
}