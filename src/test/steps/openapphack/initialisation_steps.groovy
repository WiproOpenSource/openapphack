package openapphack

import java.util.zip.ZipException
import java.util.zip.ZipFile

import static cucumber.api.groovy.EN.*
import static openapphack.stubs.WebServiceStub.primeEndpoint
import static openapphack.stubs.WebServiceStub.primeSelfupdate

And(~'^the openapphack work folder is created$') { ->
    assert openapphackDir.isDirectory(), "The openapphack directory does not exist."
}

And(~'^the "([^"]*)" folder exists in user home$') { String arg1 ->
    assert openapphackDir.isDirectory(), "The openapphack directory does not exist."
}

And(~'^the archive for candidate "([^"]*)" version "([^"]*)" is corrupt$') { String candidate, String version ->
	try {
		new ZipFile(new File("src/test/resources/__files/${candidate}-${version}.zip"))
		assert false, "Archive was not corrupt!"

	} catch (ZipException ze){
		//expected behaviour
	}
}

And(~'^the archive for candidate "([^"]*)" version "([^"]*)" is removed$') { String candidate, String version ->
	def archive = new File("${openapphackDir}/archives/${candidate}-${version}.zip")
	assert ! archive.exists()
}

And(~'^an initialised shell$') { ->
    def initScript = "$openapphackDir/bin/app-init.sh" as File
    assert initScript.exists()
}

And(~'^I reinitialise the shell$') { ->
    def initScript = "$openapphackDir/bin/app-init.sh" as File
    assert initScript.exists()
}

And(~'^the internet is reachable$') {->
    primeEndpoint("/broadcast/latest/id", "12345")
    primeEndpoint("/app/version", openapphackVersion)
    primeSelfupdate()

    forcedOffline = false
    online = true
    serviceUrlEnv = SERVICE_UP_URL
    javaHome = FAKE_JDK_PATH
}

And(~'^the internet is not reachable$') {->
    forcedOffline = false
    online = false
    serviceUrlEnv = SERVICE_DOWN_URL
    javaHome = FAKE_JDK_PATH
}

And(~'^offline mode is disabled with reachable internet$') {->
    primeEndpoint("/broadcast/latest", "This is a LIVE Broadcast!")

    forcedOffline = false
    online = true
    serviceUrlEnv = SERVICE_UP_URL
    javaHome = FAKE_JDK_PATH
}

And(~'^offline mode is enabled with reachable internet$') {->
    primeEndpoint("/broadcast/latest/id", "12345")

    forcedOffline = true
    online = true
    serviceUrlEnv = SERVICE_UP_URL
    javaHome = FAKE_JDK_PATH
}

And(~'^offline mode is enabled with unreachable internet$') {->
    forcedOffline = true
    online = false
    serviceUrlEnv = SERVICE_DOWN_URL
    javaHome = FAKE_JDK_PATH
}

And(~'^an initialised environment$') {->
    bash = env.OpenAppHackBashEnvBuilder.create(openapphackBaseDir)
        .withOnlineMode(online)
        .withForcedOfflineMode(forcedOffline)
        .withService(serviceUrlEnv)
        .withBroadcastService(serviceUrlEnv)
        .withJdkHome(javaHome)
        .withHttpProxy(HTTP_PROXY)
        .withVersionToken(openapphackVersion)
        .build()

    bash.start()
    bash.execute("source $openapphackDirEnv/bin/app-init.sh")
}

And(~'^an outdated initialised environment$') {->
    bash = env.OpenAppHackBashEnvBuilder.create(openapphackBaseDir)
        .withOnlineMode(online)
        .withForcedOfflineMode(forcedOffline)
        .withService(serviceUrlEnv)
        .withBroadcastService(serviceUrlEnv)
        .withJdkHome(javaHome)
        .withHttpProxy(HTTP_PROXY)
        .withVersionToken(openapphackVersionOutdated)
        .build()

    def twoDaysAgoInMillis = System.currentTimeMillis() - 172800000

    def upgradeToken = "$openapphackDir/var/delay_upgrade" as File
    upgradeToken.createNewFile()
    upgradeToken.setLastModified(twoDaysAgoInMillis)

    def versionToken = "$openapphackDir/var/version" as File
    versionToken.setLastModified(twoDaysAgoInMillis)

    def initFile = "$openapphackDir/bin/app-init.sh" as File
    initFile.text = initFile.text.replace(openapphackVersion, openapphackVersionOutdated)

    bash.start()
    bash.execute("source $openapphackDirEnv/bin/app-init.sh")
}

And(~'^the system is bootstrapped$') {->
    bash.execute("source $openapphackDirEnv/bin/app-init.sh")
}
