Feature: Forced Offline Mode

  #offline modes

  Scenario: Enter an invalid offline mode
    Given offline mode is disabled with reachable internet
    And an initialised environment
    When I enter "app offline panickervinod"
    Then I see "Stop! panickervinod is not a valid offline mode."

  Scenario: Issue Offline command without qualification
    Given offline mode is disabled with reachable internet
    And an initialised environment
    When I enter "app offline"
    Then I see "Stop! Specify a valid offline mode."

  Scenario: Enable Offline Mode with internet reachable
    Given offline mode is disabled with reachable internet
    And an initialised environment
    When I enter "app offline enable"
    Then I see "Forced offline mode enabled."
    And I do not see "OFFLINE MODE ENABLED!"
    When I enter "app install panickervinod master"
    Then I see "Stop! panickervinod master is not available in offline mode."

  Scenario: Disable Offline Mode with internet reachable
    Given offline mode is enabled with reachable internet
    And an initialised environment
    And the candidate "panickervinod" version "master" is available for download
    When I enter "app offline disable"
    Then I see "Online mode re-enabled!"
    When I enter "app install panickervinod master" and answer "Y"
    Then I see "Done installing!"
    And the candidate "panickervinod" version "master" is installed

  Scenario: Disable Offline Mode with internet unreachable
    Given offline mode is enabled with unreachable internet
    And an initialised environment
    When I enter "app offline disable"
    Then I see "Online mode re-enabled!"
    When I enter "app install panickervinod master"
    Then I see "OFFLINE MODE ENABLED!"
    And I see "Stop! panickervinod master is not available in offline mode."

  #broadcast
  Scenario: Recall a broadcast while Forced Offline
    Given offline mode is enabled with reachable internet
    And an initialised environment
    When a prior Broadcast "This is an OLD Broadcast!" with id "12344" was issued
    And I enter "app broadcast"
    Then I see "This is an OLD Broadcast!"

  #openapphack version
  Scenario: Determine the OpenAppHack CLI version while Forced Offline
    Given offline mode is enabled with reachable internet
    And an initialised environment
    When I enter "app version"
    Then I see the current app version

  #list candidate version
  Scenario: List candidate versions found while Forced Offline
    Given offline mode is enabled with reachable internet
    And an initialised environment
    When I enter "app list panickervinod"
    Then I see "Offline Mode: only showing installed panickervinod versions"

  #use version
  Scenario: Use an uninstalled candidate version while Forced Offline
    Given offline mode is enabled with reachable internet
    And an initialised environment
    And the candidate "panickervinod" version "0.0.1" is already installed and default
    And the candidate "panickervinod" version "master" is not installed
    When I enter "app use panickervinod master"
    Then I see "Stop! panickervinod master is not available in offline mode."

  #default version
  Scenario: Set the default to an uninstalled candidate version while Forced Offline
    Given offline mode is enabled with reachable internet
    And an initialised environment
    And the candidate "panickervinod" version "0.0.1" is already installed and default
    When I enter "app default panickervinod master"
    Then I see "Stop! panickervinod master is not available in offline mode."

  #install command
  Scenario: Install a candidate version that is not installed while Forced Offline
    Given offline mode is enabled with reachable internet
    And an initialised environment
    And the candidate "panickervinod" version "master" is not installed
    When I enter "app install panickervinod master"
    Then I see "Stop! panickervinod master is not available in offline mode."

  #uninstall command
  Scenario: Uninstall a candidate version while Forced Offline
    Given offline mode is enabled with reachable internet
    And an initialised environment
    And the candidate "panickervinod" version "master" is already installed and default
    When I enter "app uninstall panickervinod master"
    And the candidate "panickervinod" version "master" is not installed

  #current command
  Scenario: Display the current version of a candidate while Forced Offline
    Given offline mode is enabled with reachable internet
    And an initialised environment
    And the candidate "panickervinod" version "master" is already installed and default
    When I enter "app current panickervinod"
    Then I see "Using panickervinod version master"

  #help command
  Scenario: Request help while Forced Offline
    Given offline mode is enabled with reachable internet
    And an initialised environment
    When I enter "app help"
    Then I see "Usage: app <command> <candidate> [version]"

  #selfupdate command
  Scenario: Attempt self-update while Forced Offline
    Given offline mode is enabled with reachable internet
    And an initialised environment
    When I enter "app selfupdate"
    Then I see "This command is not available in offline mode."
