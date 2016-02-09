Feature: Self Update

  Background:
    Given the internet is reachable

  Scenario: Force a Selfupdate
    Given an initialised environment
    When I enter "app selfupdate force"
    Then I do not see "A new version of OPENAPPHACK is available..."
    And I do not see "Would you like to upgrade now? (Y/n)"
    And I do not see "Not upgrading today..."
    And I see "Updating openapphack..."
    And I see "Successfully upgraded OpenAppHack CLI."

  Scenario: Selfupdate when out of date
    Given an outdated initialised environment
    When I enter "app selfupdate"
    Then I do not see "A new version of OPENAPPHACK is available..."
    And I do not see "Would you like to upgrade now? (Y/n)"
    And I do not see "Not upgrading today..."
    And I see "Updating openapphack..."
    And I see "Successfully upgraded OpenAppHack CLI."

  Scenario: Agree to a suggested Selfupdate
    Given an outdated initialised environment
    When I enter "app help" and answer "Y"
    Then I see "A new version of OPENAPPHACK is available..."
    And I see "Would you like to upgrade now? (Y/n)"
    And I see "Successfully upgraded OpenAppHack CLI."
    And I do not see "Not upgrading today..."

  Scenario: Do not agree to a suggested Selfupdate
    Given an outdated initialised environment
    When I enter "app help" and answer "N"
    Then I see "A new version of OPENAPPHACK is available..."
    And I see "Would you like to upgrade now? (Y/n)"
    And I see "Not upgrading today..."
    And I do not see "Successfully upgraded OpenAppHack CLI."

  Scenario: Automatically Selfupdate
    Given an outdated initialised environment
    And the configuration file has been primed with "openapphack_auto_selfupdate=true"
    When I enter "app help"
    Then I see "A new version of OPENAPPHACK is available..."
    And I do not see "Would you like to upgrade now? (Y/n)"
    And I do not see "Not upgrading today..."
    And I see "Successfully upgraded OpenAppHack CLI."

  Scenario: Do not automatically Selfupdate
    Given an outdated initialised environment
    And the configuration file has been primed with "openapphack_auto_selfupdate=false"
    When I enter "app help" and answer "n"
    Then I see "A new version of OPENAPPHACK is available..."
    And I see "Would you like to upgrade now? (Y/n)"
    And I see "Not upgrading today..."
    And I do not see "Successfully upgraded OpenAppHack CLI."

  Scenario: Bother the user with Upgrade message once a day
    Given an outdated initialised environment
    When I enter "app help" and answer "N"
    Then I see "A new version of OPENAPPHACK is available..."
    And I see "Would you like to upgrade now? (Y/n)"
    And I see "Not upgrading today..."
    And I enter "app help"
    Then I do not see "A new version of OPENAPPHACK is available..."
    And I do not see "Would you like to upgrade now? (Y/n)"
    And I do not see "Not upgrading now..."
    And I do not see "Successfully upgraded OpenAppHack CLI."

  Scenario: Selfupdate when not out of date
    Given an initialised environment
    When I enter "app selfupdate"
    Then I see "No update available at this time."
