Feature: Install Candidate

  Background:
    Given the internet is reachable
    And an initialised environment

  Scenario: Install a default Candidate
    Given the default "panickervinod" candidate is "master"
    When I enter "app install panickervinod" and answer "Y"
    Then I see "Done installing!"
    Then the candidate "panickervinod" version "master" is installed

  Scenario: Install a specific Candidate
    And the candidate "openapphack" version "master" is available
    When I enter "app install openapphack master" and answer "Y"
    Then I see "Done installing!"
    Then the candidate "openapphack" version "master" is installed

  Scenario: Install a Candidate version that does not exist
    Given the candidate "openapphack" version "0.0.1" is not available
    When I enter "app install openapphack 0.0.1"
    Then I see "Stop! 0.0.1 is not a valid openapphack version."

  Scenario: Install a Candidate version that is already installed
    Given the candidate "panickervinod" version "master" is available
    And the candidate "panickervinod" version "master" is already installed and default
    When I enter "app install panickervinod master"
    Then I see "Stop! panickervinod master is already installed."

  Scenario: Install a candidate and select to use it
    Given the candidate "panickervinod" version "0.0.1" is available
    When I enter "app install panickervinod 0.0.1" and answer "Y"
    Then the candidate "panickervinod" version "0.0.1" is installed
    And I see "Done installing!"
    And I see "Do you want panickervinod 0.0.1 to be set as default? (Y/n)"
    And I see "Setting panickervinod 0.0.1 as default."
    Then the candidate "panickervinod" version "0.0.1" should be the default

  Scenario: Install a candidate and select to use it automatically
    Given the candidate "panickervinod" version "0.0.1" is available
    And I have configured "openapphack_auto_answer" to "true"
    When I enter "app install panickervinod 0.0.1"
    Then the candidate "panickervinod" version "0.0.1" is installed
    And I see "Done installing!"
    And I see "Setting panickervinod 0.0.1 as default."
    Then the candidate "panickervinod" version "0.0.1" should be the default

  Scenario: Install a candidate and do not select to use it
    Given the candidate "panickervinod" version "0.0.1" is available
    When I enter "app install panickervinod 0.0.1" and answer "n"
    Then the candidate "panickervinod" version "0.0.1" is installed
    And I see "Done installing!"
    And I see "Do you want panickervinod 0.0.1 to be set as default? (Y/n)"
    And I do not see "Setting panickervinod 0.0.1 as default."
    Then the candidate "panickervinod" version "0.0.1" should not be the default

  #revisit to reinstall automatically
  Scenario: Abort installation of a incorrect Candidate
    Given the candidate "panickervinod" version "0.0.0" is available
    And the archive for candidate "panickervinod" version "0.0.0" is corrupt
    When I enter "app install panickervinod 0.0.0"
    Then I see "Stop! incorrect candidate! Please try installing again."
    And the candidate "panickervinod" version "0.0.0" is not installed
    And the archive for candidate "panickervinod" version "0.0.0" is removed
