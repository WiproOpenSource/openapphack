Feature: Offline Mode

  Background:
    Given the internet is not reachable
    And an initialised environment

  # list command

  Scenario: List candidate versions found while Offline
    Given the candidate "panickervinod" version "master" is already installed and default
    And the candidate "panickervinod" version "0.0.1" is already installed but not default
    When I enter "app list panickervinod"
    Then I see "Offline Mode: only showing installed panickervinod versions"
    And I see "> master"
    And I see "* 0.0.1"

  Scenario: List candidate versions not found while Offline
    When I enter "app list panickervinod"
    Then I see "Offline Mode: only showing installed panickervinod versions"
    And I see "None installed!"

# use command

  Scenario: Use the default candidate version while Offline
    Given the candidate "panickervinod" version "master" is already installed and default
    And the candidate "panickervinod" version "0.0.1" is already installed but not default
    When I enter "app use panickervinod"
    Then I see "Using panickervinod version master in this shell."

  Scenario: Use the default candidate version when non selected while Offline
    Given the candidate "panickervinod" version "0.0.1" is already installed but not default
    Given the candidate "panickervinod" version "master" is already installed but not default
    When I enter "app use panickervinod"
    Then I see "This command is not available in offline mode."

  Scenario: Use an uninstalled candidate version while Offline
    Given the candidate "panickervinod" version "0.0.1" is already installed and default
    And the candidate "panickervinod" version "master" is not installed
    When I enter "app use panickervinod master"
    Then I see "Stop! panickervinod master is not available in offline mode."

  Scenario: Use an invalid candidate version while Offline
    Given the candidate "panickervinod" version "0.0.1" is already installed and default
    When I enter "app use panickervinod 9.9.9"
    Then I see "Stop! panickervinod 9.9.9 is not available in offline mode."

  Scenario: Use an installed candidate version while Offline
    Given the candidate "panickervinod" version "master" is already installed and default
    And the candidate "panickervinod" version "0.0.1" is already installed but not default
    When I enter "app use panickervinod 0.0.1"
    Then I see "Using panickervinod version 0.0.1 in this shell."

  # default command

  Scenario: Set the default to an uninstalled candidate version while Offline
    Given the candidate "panickervinod" version "0.0.1" is already installed and default
    When I enter "app default panickervinod master"
    Then I see "Stop! panickervinod master is not available in offline mode."

  Scenario: Set the default to an invalid candidate version while Offline
    Given the candidate "panickervinod" version "0.0.1" is already installed and default
    When I enter "app default panickervinod 999"
    Then I see "Stop! panickervinod 999 is not available in offline mode."

  Scenario: Set the default to an installed candidate version while Offline
    Given the candidate "panickervinod" version "master" is already installed and default
    And the candidate "panickervinod" version "0.0.1" is already installed but not default
    When I enter "app default panickervinod 0.0.1"
    Then I see "Default panickervinod version set to 0.0.1"

  # install command
  Scenario: Install a candidate version that is not installed while Offline
    Given the candidate "panickervinod" version "master" is not installed
    When I enter "app install panickervinod master"
    Then I see "Stop! panickervinod master is not available in offline mode."

  Scenario: Install a candidate version that is already installed while Offline
    Given the candidate "panickervinod" version "master" is already installed and default
    When I enter "app install panickervinod master"
    Then I see "Stop! panickervinod master is already installed."

  # uninstall command
  Scenario: Uninstall a candidate version while Offline
    Given the candidate "panickervinod" version "master" is already installed and default
    When I enter "app uninstall panickervinod master"
    Then I see "Unselecting panickervinod master..."
    And I see "Uninstalling panickervinod master..."
    And the candidate "panickervinod" version "master" is not in use
    And the candidate "panickervinod" version "master" is not installed

  Scenario: Uninstall a candidate version that is not installed while Offline
    Given the candidate "panickervinod" version "master" is not installed
    When I enter "app uninstall panickervinod master"
    Then I see "panickervinod master is not installed."

  # current command
  Scenario: Display the current version of a candidate while Offline
    Given the candidate "panickervinod" version "master" is already installed and default
    When I enter "app current panickervinod"
    Then I see "Using panickervinod version master"

  Scenario: Display the current version of all candidates while Offline
    Given the candidate "panickervinod" version "master" is already installed and default
    And the candidate "openapphack" version "master" is already installed and default
    When I enter "app current"
	Then I see "Using:"
	And I see "panickervinod: master"
	And I see "openapphack: master"

  # version command
  Scenario: Determine the OpenAppHack CLI version when Offline
    When I enter "app version"
    Then I see the current app version

  # broadcast command
  Scenario: Recall a broadcast while Offline
    Given a prior Broadcast "This is an OLD Broadcast!" with id "12344" was issued
    When I enter "app broadcast"
    Then I see "This is an OLD Broadcast!"

  # help command
  Scenario: Request help while Offline
    When I enter "app help"
    Then I see "Usage: app <command> <candidate> [version]"

  # selfupdate command
  Scenario: Attempt self-update while Offline
    When I enter "app selfupdate"
    Then I see "This command is not available in offline mode."
