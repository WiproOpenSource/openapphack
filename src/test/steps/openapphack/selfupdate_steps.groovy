package openapphack

import static cucumber.api.groovy.EN.And

And(~'^the configuration file has been primed with "([^"]*)"$') { String content ->
    def configFile = "$openapphackDir/etc/config" as File
    configFile << content
}

And(~'^the configuration file has not been primed$') { ->
    def configFile = "$openapphackDir/etc/config" as File
    if (configFile.exists()) {
        configFile.delete()
    }
}

And(~'^the configuration file is present$') { ->
    def configFile = "$openapphackDir/etc/config" as File
    assert configFile.exists()
}

And(~'^the configuration file contains "([^"]*)"$') { String content ->
    def configFile = "$openapphackDir/etc/config" as File
    assert configFile.text.contains(content)
}

And(~'^the configuration file does not contain "([^"]*)"$') { String content ->
    def configFile = "$openapphackDir/etc/config" as File
    assert !configFile.text.contains(content)
}

And(~'^a configuration file in the extensions folder$') { ->
    def configFile = "$openapphackDir/ext/config" as File
    configFile.text = ""
}

And(~'^the configuration is not present in the extensions folder$') { ->
    def configFile = "$openapphackDir/ext/config" as File
    assert !configFile.exists()
}

And(~'^the configuration file is present in the etc folder$') { ->
    def configFile = "$openapphackDir/etc/config" as File
    assert configFile.exists()
}

And(~'^the openapphack init script is placed in the bin folder$') { ->
    assert new File("$openapphackDir/bin", "app-init.sh").exists()
}

And(~'^the openapphack module scripts are placed in the src folder$') { ->
    assert new File("$openapphackDir/src", "app-common.sh").exists()
    assert new File("$openapphackDir/src", "app-main.sh").exists()
    assert new File("$openapphackDir/src", "app-broadcast.sh").exists()
    assert new File("$openapphackDir/src", "app-current.sh").exists()
    assert new File("$openapphackDir/src", "app-default.sh").exists()
    assert new File("$openapphackDir/src", "app-install.sh").exists()
    assert new File("$openapphackDir/src", "app-list.sh").exists()
    assert new File("$openapphackDir/src", "app-selfupdate.sh").exists()
    assert new File("$openapphackDir/src", "app-uninstall.sh").exists()
    assert new File("$openapphackDir/src", "app-use.sh").exists()
    assert new File("$openapphackDir/src", "app-version.sh").exists()
    assert new File("$openapphackDir/src", "app-help.sh").exists()
}

And(~'^the staging folder is cleaned up$') { ->
    assert !new File("$openapphackDir/tmp/stage").exists()
}

And(~'^an empty configuration file$') { ->
    def configFile = "$openapphackDir/ext/config" as File
    configFile.text = ""
}