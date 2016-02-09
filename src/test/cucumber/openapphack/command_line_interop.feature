Feature: Command Line Interop

  Background:
    Given the internet is reachable
    And an initialised environment

  Scenario: Enter app
    When I enter "app"
    Then I see "Usage: app <command> <candidate> [version]"
    And I see "app offline <enable|disable>"

  Scenario: Ask for help
    When I enter "app help"
    Then I see "Usage: app <command> <candidate> [version]"

  Scenario: Enter an invalid Command
    When I enter "app somecommand openapphack"
    Then I see "Invalid command: somecommand"
    And I see "Usage: app <command> <candidate> [version]"

  Scenario: Enter an invalid Candidate
    When I enter "app install something"
    Then I see "Stop! something is not a valid candidate."
