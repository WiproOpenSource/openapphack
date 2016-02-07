package openapphack.env

import openapphack.stubs.CurlStub

class OpenAppHackBashEnvBuilder {

    final TEST_SCRIPT_BUILD_DIR = "build/testScripts" as File

    //mandatory fields
    private final File baseFolder

    //optional fields with sensible defaults
    CurlStub curlStub
    List candidates = ['openapphack', 'panickervinod']
    List availableCandidates = candidates
    boolean onlineMode = true
    boolean forcedOfflineMode = false
    String broadcast = "This is a LIVE broadcast!"
    String service = "http://localhost:8080"
    String broadcastService = "http://localhost:8080"
    String brokerService = "http://localhost:8080"
    String jdkHome = "/path/to/my/jdk"
    String httpProxy
    String versionToken

    Map config = [
            openapphack_auto_answer:'false'
    ]

    File openapphackDir, openapphackBinDir, openapphackVarDir, openapphackSrcDir, openapphackEtcDir, openapphackExtDir, openapphackArchivesDir, openapphackTmpDir

    static OpenAppHackBashEnvBuilder create(File baseFolder){
        new OpenAppHackBashEnvBuilder(baseFolder)
    }

    private OpenAppHackBashEnvBuilder(File baseFolder){
        this.baseFolder = baseFolder
    }

    OpenAppHackBashEnvBuilder withCurlStub(CurlStub curlStub){
        this.curlStub = curlStub
        this
    }

    OpenAppHackBashEnvBuilder withCandidates(List candidates){
        this.candidates = candidates
        this
    }

    OpenAppHackBashEnvBuilder withAvailableCandidates(List candidates){
        this.availableCandidates = candidates
        this
    }

    OpenAppHackBashEnvBuilder withBroadcast(String broadcast){
        this.broadcast = broadcast
        this
    }

    OpenAppHackBashEnvBuilder withConfiguration(String key, String value){
        config.put key, value
        this
    }

    OpenAppHackBashEnvBuilder withOnlineMode(boolean onlineMode){
        this.onlineMode = onlineMode
        this
    }

    OpenAppHackBashEnvBuilder withForcedOfflineMode(boolean forcedOfflineMode){
        this.forcedOfflineMode = forcedOfflineMode
        this
    }

    OpenAppHackBashEnvBuilder withService(String service){
        this.service = service
        this
    }

    OpenAppHackBashEnvBuilder withBroadcastService(String broadcastService){
        this.broadcastService = broadcastService
        this
    }

    OpenAppHackBashEnvBuilder withBrokerService(String brokerService){
        this.brokerService = brokerService
        this
    }

    OpenAppHackBashEnvBuilder withJdkHome(String jdkHome){
        this.jdkHome = jdkHome
        this
    }

    OpenAppHackBashEnvBuilder withHttpProxy(String httpProxy){
        this.httpProxy = httpProxy
        this
    }

    OpenAppHackBashEnvBuilder withVersionToken(String version){
        this.versionToken = version
        this
    }

    BashEnv build() {
        openapphackDir = prepareDirectory(baseFolder, ".openapphack")
        openapphackBinDir = prepareDirectory(openapphackDir, "bin")
        openapphackVarDir = prepareDirectory(openapphackDir, "var")
        openapphackSrcDir = prepareDirectory(openapphackDir, "src")
        openapphackEtcDir = prepareDirectory(openapphackDir, "etc")
        openapphackExtDir = prepareDirectory(openapphackDir, "ext")
        openapphackArchivesDir = prepareDirectory(openapphackDir, "archives")
        openapphackTmpDir = prepareDirectory(openapphackDir, "tmp")

        initializeCandidates(openapphackDir, candidates)
        initializeAvailableCandidates(openapphackVarDir, availableCandidates)
        initializeBroadcast(openapphackVarDir, broadcast)
        initializeConfiguration(openapphackEtcDir, config)
        initializeVersionToken(openapphackVarDir, versionToken)

        primeInitScript(openapphackBinDir)
        primeModuleScripts(openapphackSrcDir)

        def env = [
                OPENAPPHACK_DIR: openapphackDir.absolutePath,
                OPENAPPHACK_ONLINE: "$onlineMode",
                OPENAPPHACK_FORCE_OFFLINE: "$forcedOfflineMode",
                OPENAPPHACK_SERVICE: service,
                OPENAPPHACK_BROADCAST_SERVICE: broadcastService,
                OPENAPPHACK_BROKER_SERVICE: brokerService,
                JAVA_HOME: jdkHome
        ]

        if(httpProxy) {
            env.put("http_proxy", httpProxy)
        }

        new BashEnv(baseFolder.absolutePath, env)
    }

    private prepareDirectory(File target, String directoryName) {
        def directory = new File(target, directoryName)
        directory.mkdirs()
        directory
    }

    private initializeVersionToken(File folder, String version) {
        if(version) {
            new File(folder, "version") << version
        }
    }


    private initializeCandidates(File folder, List candidates) {
        candidates.each { candidate ->
            new File(folder, candidate).mkdirs()
        }
    }

    private initializeAvailableCandidates(File folder, List candidates){
        new File(folder, "candidates") << candidates.join(",")
    }

    private initializeBroadcast(File targetFolder, String broadcast) {
        new File(targetFolder, "broadcast") << broadcast
    }

    private initializeConfiguration(File targetFolder, Map config){
        def configFile = new File(targetFolder, "config")
        config.each { key, value ->
            configFile << "$key=$value\n"
        }
    }

    private primeInitScript(File targetFolder) {
        def sourceInitScript = new File(TEST_SCRIPT_BUILD_DIR, 'app-init.sh')

        if (!sourceInitScript.exists())
            throw new IllegalStateException("app-init.sh has not been prepared for consumption.")

        def destInitScript = new File(targetFolder, "app-init.sh")
        destInitScript << sourceInitScript.text
        destInitScript
    }

    private primeModuleScripts(File targetFolder){
        for (f in TEST_SCRIPT_BUILD_DIR.listFiles()){
            if(!(f.name in ['selfupdate.sh', 'install.sh', 'app-init.sh'])){
                new File(targetFolder, f.name) << f.text
            }
        }
    }

}
