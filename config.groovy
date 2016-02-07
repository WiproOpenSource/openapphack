vertxVersion = '1.3.1.final'
openapphackVersion = '0.0.1'
environments {
	local {
		    openapphackService = 'http://localhost:8080'
        openapphackBroadcastService = 'http://localhost:8080'
        openapphackBrokerService = 'http://localhost:8080'
	}
	master {
		    openapphackService = 'http://panickervinod.github.io/openapphack'
        openapphackBroadcastService = 'http://panickervinod.github.io/openapphack/broadcast'
        openapphackBrokerService = 'http://panickervinod.github.io/openapphack/broker'
	}
	production {
		    openapphackService = 'http://openapphack.github.io/openapphack/broadcast'
        openapphackBroadcastService = 'http://openapphack.github.io/openapphack/broadcast'
        openapphackBrokerService = 'http://openapphack.github.io/openapphack/broker'
	}
}
