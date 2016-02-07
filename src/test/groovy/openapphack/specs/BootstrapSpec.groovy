package openapphack.specs

import openapphack.env.BashEnv
import openapphack.stubs.CurlStub
import openapphack.env.OpenAppHackBashEnvBuilder
import spock.lang.Specification

import static openapphack.utils.TestUtils.prepareBaseDir

class BootstrapSpec extends Specification {

    CurlStub curlStub
    BashEnv bash

    File openapphackBaseDir
    String openapphackBaseEnv
    String bootstrap
    String versionToken

    void setup(){
        openapphackBaseDir = prepareBaseDir()
        openapphackBaseEnv = openapphackBaseDir.absolutePath
        bootstrap = "${openapphackBaseDir.absolutePath}/.openapphack/bin/app-init.sh"
        versionToken = "${openapphackBaseDir.absolutePath}/.openapphack/var/version"
        curlStub = CurlStub.prepareIn(new File(openapphackBaseDir, "bin"))
    }

    void "should store version token if not exists"() {

        given: 'a working openapphack installation without version token'
        def versionFile = new File(versionToken)
        curlStub.primeWith("http://localhost:8080/app/version", "echo x.y.b").build()
        bash = OpenAppHackBashEnvBuilder
                .create(openapphackBaseDir)
                .withCurlStub(curlStub)
                .build()
        bash.start()

        when: 'bootstrap the system'
        bash.execute("source $bootstrap")

        then:
        versionFile.exists()
    }

    void "should not query server if token is found"() {
        given: 'a working openapphack installation with version token'
        def versionFile = new File(versionToken)
        bash = OpenAppHackBashEnvBuilder
                .create(openapphackBaseDir)
                .withCurlStub(curlStub)
                .withVersionToken("x.y.z")
                .build()
        bash.start()

        when: 'bootstrap the system'
        bash.execute("source $bootstrap")

        then:
        versionFile.exists()
        versionFile.text.contains("x.y.z")
    }

    void "should query server for version and refresh if token is older than a day"() {
        given: 'a working openapphack installation with expired version token'
        def versionFile = new File(versionToken)
        curlStub.primeWith("http://localhost:8080/app/version", "echo x.y.b").build()
        bash = OpenAppHackBashEnvBuilder
                .create(openapphackBaseDir)
                .withCurlStub(curlStub)
                .withVersionToken("x.y.a")
                .build()
        def twoDaysAgoInMillis = System.currentTimeMillis() - 172800000
        versionFile.setLastModified(twoDaysAgoInMillis)
        bash.start()

        when: 'bootstrap the system'
        bash.execute("source $bootstrap")

        then:
        versionFile.exists()
        versionFile.text.contains("x.y.b")
    }

    void "should ignore version if api is offline"(){
        given: 'a working openapphack installation with api down'
        def openapphackVersion = "x.y.z"
        def versionFile = new File(versionToken)
        curlStub.primeWith("http://localhost:8080/app/version", "echo ''").build()
        bash = OpenAppHackBashEnvBuilder
                .create(openapphackBaseDir)
                .withCurlStub(curlStub)
                .withVersionToken(openapphackVersion)
                .build()
        bash.start()

        when: 'bootstrap the system'
        bash.execute("source $bootstrap")

        then:
        versionFile.text.contains(openapphackVersion)
    }

    void "should not go offline if curl times out"(){
        given: 'a working openapphack installation with api down'
        curlStub.primeWith("http://localhost:8080/app/version", "echo ''").build()
        bash = OpenAppHackBashEnvBuilder
                .create(openapphackBaseDir)
                .withCurlStub(curlStub)
                .build()
        bash.start()

        when: 'bootstrap the system'
        bash.execute("source $bootstrap")

        then:
        ! bash.output.contains("OPENAPPHACK can't reach the internet so going offline.")
    }

    void "should ignore version if api returns garbage"(){
        given: 'a working openapphack installation with garbled api'
        def openapphackVersion = "x.y.z"
        def versionFile = new File(versionToken)
        curlStub.primeWith("http://localhost:8080/app/version", "echo '<html><title>sorry</title></html>'").build()
        bash = OpenAppHackBashEnvBuilder
                .create(openapphackBaseDir)
                .withCurlStub(curlStub)
                .withVersionToken(openapphackVersion)
                .build()
        bash.start()

        when: 'bootstrap the system'
        bash.execute("source $bootstrap")

        then:
        versionFile.text.contains openapphackVersion
    }

    void cleanup(){
        println bash.output
        bash.stop()
        assert openapphackBaseDir.deleteDir()
    }
}
