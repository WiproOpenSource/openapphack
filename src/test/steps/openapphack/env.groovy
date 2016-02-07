package openapphack

import com.github.tomakehurst.wiremock.WireMockServer
import com.github.tomakehurst.wiremock.client.WireMock

import static com.github.tomakehurst.wiremock.core.WireMockConfiguration.wireMockConfig
import static cucumber.api.groovy.Hooks.After
import static cucumber.api.groovy.Hooks.Before

HTTP_PROXY = System.getProperty("httpProxy") ?: ""

FAKE_JDK_PATH = "/path/to/my/openjdk"
SERVICE_UP_HOST="localhost"
SERVICE_UP_PORT=8080
SERVICE_UP_URL = "http://$SERVICE_UP_HOST:$SERVICE_UP_PORT"
SERVICE_DOWN_URL = "http://localhost:0"

counter = "${(Math.random() * 10000).toInteger()}".padLeft(4, "0")

localOpenapphackCandidate = "/tmp/openapphack-core" as File

openapphackVersion = "x.y.z"
openapphackVersionOutdated = "x.y.y"

openapphackBaseEnv = "/tmp/app-$counter"
openapphackBaseDir = openapphackBaseEnv as File

openapphackDirEnv = "$openapphackBaseEnv/.openapphack"
openapphackDir = openapphackDirEnv as File
binDir = "${openapphackDirEnv}/bin" as File
srcDir = "${openapphackDirEnv}/src" as File
varDir = "${openapphackDirEnv}/var" as File
etcDir = "${openapphackDirEnv}/etc" as File
extDir = "${openapphackDirEnv}/ext" as File
archiveDir = "${openapphackDirEnv}/archives" as File
tmpDir = "${openapphackDir}/tmp" as File

broadcastFile = new File(varDir, "broadcast")
broadcastIdFile = new File(varDir, "broadcast_id")
candidatesFile = new File(varDir, "candidates")
versionTokenFile = new File(varDir, "version")
initScript = new File(binDir, "app-init.sh")

bash = null

if(!binding.hasVariable("wireMock")) {
    wireMock = new WireMockServer(wireMockConfig().port(SERVICE_UP_PORT))
    wireMock.start()
    WireMock.configureFor(SERVICE_UP_HOST, SERVICE_UP_PORT)
}

Before(){
    WireMock.reset()
    cleanUp()
}

private cleanUp(){
    openapphackBaseDir.deleteDir()
    localOpenapphackCandidate.deleteDir()
}

After(){ scenario ->
    def output = bash?.output
    if (output) {
        scenario.write("\nOutput: \n${output}")
    }
	bash?.stop()
}
