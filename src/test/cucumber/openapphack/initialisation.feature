Feature: Initialisation

  Background:
    Given the internet is reachable
    And an initialised environment

  Scenario: Use app for the first time
    When I enter "app"
    Then the openapphack work folder is created

  Scenario: Use app after initialisation
    When I enter "app"
    Then I see "Usage: app <command> <candidate> [version]"
    Then the openapphack work folder is created

  Scenario: app is initialised for the first time
    Given an initialised shell
    When I enter "echo $OPENAPPHACK_INIT"
    Then I see "true"
    When I enter "echo $PATH"
    Then I see a single occurrence of "panickervinod"

  Scenario: app is initialised a subsequent time
    Given an initialised shell
    When I reinitialise the shell
    And I enter "echo $PATH"
    Then I see a single occurrence of "panickervinod"
