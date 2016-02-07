Feature: Use and Default Candidate

  Background:
    Given the internet is reachable
    And an initialised environment

  Scenario: Use without providing a Candidate
    When I enter "app use"
    Then I see "Usage: app <command> <candidate> [version]"

  Scenario: Use a candidate version that is installed
    Given the candidate "panickervinod" version "master" is already installed and default
    And the candidate "panickervinod" version "0.0.1" is a valid candidate version
    And the candidate "panickervinod" version "0.0.1" is already installed but not default
    When I enter "app use panickervinod 0.0.1"
    Then I see "Using panickervinod version 0.0.1 in this shell."
    Then the candidate "panickervinod" version "0.0.1" should be in use
    And the candidate "panickervinod" version "master" should be the default

  Scenario: Use a candidate version that is not installed
    Given the candidate "panickervinod" version "0.0.1" is available for download
    When I enter "app use panickervinod 0.0.1" and answer "Y"
    Then I see "Using panickervinod version 0.0.1 in this shell."
    And the candidate "panickervinod" version "0.0.1" should be in use

  Scenario: Use a candidate version that is automatically installed
    Given I have configured "openapphack_auto_answer" to "true"
    And the candidate "panickervinod" version "0.0.1" is available for download
    When I enter "app use panickervinod 0.0.1"
    Then I see "Stop! panickervinod 0.0.1 is not installed."
    Then I see "Using panickervinod version 0.0.1 in this shell."
    And the candidate "panickervinod" version "0.0.1" should be in use

  Scenario: Use a candidate version that does not exist
    Given the candidate "openapphack" version "1.9.9" is not available for download
    When I enter "app use openapphack 1.9.9"
    Then I see "Stop! 1.9.9 is not a valid openapphack version."

  Scenario: Use a candidate version that only exists locally
    Given the candidate "panickervinod" version "2.0.0.M1" is not available for download
    And the candidate "panickervinod" version "2.0.0.M1" is already installed but not default
    When I enter "app use panickervinod 2.0.0.M1"
    Then I see "Using panickervinod version 2.0.0.M1 in this shell."

  Scenario: Default a candidate version that is not installed
    Given the candidate "openapphack" version "master" is a valid candidate version
    When I enter "app default openapphack master"
    Then I see "Stop! openapphack master is not installed."

  Scenario: Default a candidate version that is installed and not default
    Given the candidate "openapphack" version "master" is a valid candidate version
    And the candidate "openapphack" version "master" is already installed but not default
    When I enter "app default openapphack master"
    Then I see "Default openapphack version set to master"
    And the candidate "openapphack" version "master" should be the default

  Scenario: Default a candidate version that is installed and already default
    Given the candidate "openapphack" version "master" is a valid candidate version
    And the candidate "openapphack" version "master" is already installed and default
    When I enter "app default openapphack master"
    Then I see "Default openapphack version set to master"
    And the candidate "openapphack" version "master" should be the default

  Scenario: Default a candidate version that does not exist
    Given the candidate "openapphack" version "2.9.9" is not available for download
    When I enter "app default openapphack 2.9.9"
    Then I see "Stop! 2.9.9 is not a valid openapphack version."
