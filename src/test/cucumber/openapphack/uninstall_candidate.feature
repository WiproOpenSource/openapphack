Feature: Uninstall Candidate

  Background:
    Given the internet is reachable
    And an initialised environment

  Scenario: Uninstall an installed Candidate Version not in use
    Given the candidate "panickervinod" version "master" is already installed but not default
    When I enter "app uninstall panickervinod master"
    Then I do not see "Unselecting panickervinod master"
    Then I see "Uninstalling panickervinod master"
    And the candidate "panickervinod" version "master" is not installed

  Scenario: Uninstall a Candidate Version in use
    Given the candidate "panickervinod" version "master" is already installed and default
    When I enter "app uninstall panickervinod master"
    Then I see "Unselecting panickervinod master"
    And I see "Uninstalling panickervinod master"
    And the candidate "panickervinod" version "master" is not installed
    And the candidate "panickervinod" is no longer selected

  Scenario: Attempt uninstalling a Candidate Version that is not installed
    Given the candidate "panickervinod" version "0.0.1" is not installed
    When I enter "app uninstall panickervinod 0.0.1"
    Then I see "panickervinod 0.0.1 is not installed."

  Scenario: Attempt uninstalling with no Candidate specified
    When I enter "app uninstall"
    Then I see "No candidate provided."

  Scenario: Attempt uninstalling with an invalid Candidate specified
    When I enter "app uninstall groffle"
    Then I see "Stop! groffle is not a valid candidate."

  Scenario: Attempt uninstalling without a version provided
    When I enter "app uninstall panickervinod"
    Then I see "No candidate version provided."
