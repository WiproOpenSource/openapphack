vertxVersion = '1.3.1.final'
openapphackVersion = '0.0.1'
environments {
	local {
		    openapphackService = 'http://localhost:8080'
        openapphackBroadcastService = 'http://localhost:8080'
        openapphackBrokerService = 'http://localhost:8080'
	}
	master {
		    openapphackService = 'https://raw.githubusercontent.com/WiproOpenSourcePractice/openapphack/gh-pages'
        openapphackBroadcastService = 'https://raw.githubusercontent.com/WiproOpenSourcePractice/openapphack/gh-pages/broadcast'
        openapphackBrokerService = 'https://raw.githubusercontent.com/WiproOpenSourcePractice/openapphack/gh-pages/broker'
	}
	production {
		    openapphackService = 'https://raw.githubusercontent.com/openapphack/openapphack/gh-pages'
        openapphackBroadcastService = 'https://raw.githubusercontent.com/openapphack/openapphack/gh-pages/broadcast'
        openapphackBrokerService = 'https://raw.githubusercontent.com/openapphack/openapphack/gh-pages/broker'
	}
}
