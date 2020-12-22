definition(
    name: "Big Turn ON modified",
    namespace: "smartthings",
    author: "Anonymous",
    description: "Turn your lights on when the SmartApp is tapped or activated.",
    category: "Convenience",
    iconUrl: "https://s3.amazonaws.com/smartapp-icons/Meta/light_outlet.png",
    iconX2Url: "https://s3.amazonaws.com/smartapp-icons/Meta/light_outlet@2x.png"
)

preferences {
	section("When I touch the app, turn on...") {
		input "switches", "capability.switch", multiple: false
	
    input name: "email", type: "email", title: "Email", description: "Enter Email Address", required: true,
          displayDuringSetup: true
}
}


def installed()
{
   	atomicState.SmartLightTimes = [:]
   	atomicState.SmartLightAdmins = [:]
   	atomicState.SmartLightUsers = [:]
   	atomicState.SmartLightDevID = [:]
   	atomicState.SmartLightTimeStart = [:]
   	atomicState.SmartLightTimeEnd = [:]
    
    log.debug "${new Date()}"
   
  	getSmartLightJsonData()
    
    def item = atomicState.SmartLightUsers.indexOf(email)
    if (item>=0){
    	int index = atomicState.SmartLightUsers.indexOf(email)
        def between = timeBetween (atomicState.SmartLightTimeStart[index], atomicState.SmartLightTimeEnd[index])
        if (between == true){
            subscribe(location, changedLocationMode)
            subscribe(app, appTouch)
            log.info app.getAccountId()}
    }
}

def updated()
{
	atomicState.SmartLightTimes = [:]
   	atomicState.SmartLightAdmins = [:]
   	atomicState.SmartLightUsers = [:]
   	atomicState.SmartLightDevID = [:]
   	atomicState.SmartLightTimeStart = [:]
   	atomicState.SmartLightTimeEnd = [:]
   
    getSmartLightJsonData()
    
    def item = atomicState.SmartLightUsers.indexOf(email)
    if (item>=0){
    	int index = atomicState.SmartLightUsers.indexOf(email)
        def between = timeBetween (atomicState.SmartLightTimeStart[index], atomicState.SmartLightTimeEnd[index])
        if (between == true){
            unsubscribe()
            subscribe(location, changedLocationMode)
            subscribe(app, appTouch)
    	}
	}
}

def changedLocationMode(evt) {
	log.debug "changedLocationMode: $evt"
	switches?.on()
}

def appTouch(evt) {
	log.debug "appTouch: $evt"
	switches?.on()
}

def getSmartLightJsonData(){
    def listTimes = []
    def listAdmins = []
    def listUsers = []
    def listIDs = []
    def listTimeStarts = []
    def listTimeEnds = []
        
    def params = [
        uri: "https://mywebserver/xxxyyyzzz/2/public/values?alt=json",
    ]

    try {
        httpGet(params) { resp ->
            
            //log.debug "${resp.data}" 
            
            for (object in resp.data.feed.entry){
				listTimes.add (object.gsx$time.$t)
                listAdmins.add (object.gsx$adminemail.$t)
                listUsers.add (object.gsx$restricteduseremail.$t)
                listIDs.add (object.gsx$deviceid.$t)  
                listTimeStarts.add (object.gsx$timerangestart.$t)    
                listTimeEnds.add (object.gsx$timerangeend.$t)    
            }
            
            atomicState.SmartLightTimes = (listTimes)
            atomicState.SmartLightAdmins = (listAdmins)
            atomicState.SmartLightUsers = (listUsers)
            atomicState.SmartLightDevID = (listIDs)
            atomicState.SmartLightTimeStart = (listTimeStarts)
            atomicState.SmartLightTimeEnd = (listTimeEnds)

            /*for (listtime in atomicState.SmartLightTimes){
            	log.debug "${listtime}" 
            }*/          
        }
    } catch (e) {
        log.error "something went wrong: $e"
    }
}

def timeBetween(String start, String end){
    long timeDiff
    def now = new Date()
    def timeStart = Date.parse("yyy-MM-dd'T'HH:mm:ss","${start}".replace(".000-0400",""))
    def timeEnd = Date.parse("yyy-MM-dd'T'HH:mm:ss","${end}".replace(".000-0400",""))
    
    long unxNow = now.getTime()
    long unxEnd = timeEnd.getTime()
    long unxStart = timeStart.getTime()
    
    if (unxNow >= unxStart && unxNow <= unxEnd)
    	return true
    else
    	return false
 }