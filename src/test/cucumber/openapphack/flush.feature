Feature: Flush

  Background:
    Given the internet is reachable
    And an initialised environment

  Scenario: Flush omitting the Qualifier
    When I enter "app flush"
    Then I see "Stop! Please specify what you want to flush."

  Scenario: Clear out the Candidate List
    Given the candidate "panickervinod" is known locally
    When I enter "app flush candidates"
    Then no candidates are know locally
    And I see "Candidates have been flushed."

  Scenario: Clear out an uninitialised Candidate List
    Given I enter "app flush candidates"
    When I enter "app flush candidates"
    Then I see "No candidate list found so not flushed."

  Scenario: Clean up the current Broadcast
    Given a prior Broadcast "This is an old broadcast" with id "12344" was issued
    When I enter "app flush broadcast"
    Then no broadcast message can be found
    And I see "Broadcast has been flushed."

  Scenario: Clean up an uninitialised Broadcast
    Given the broadcast has been flushed
    When I enter "app flush broadcast"
    Then I see "No prior broadcast found so not flushed."

  Scenario: Clean up the last known Remote Version
    Given a prior version "x.y.z" was detected
    When I enter "app flush version"
    Then no version token can be found
    And I see "Version Token has been flushed."

  Scenario: Clean up an uninitialised last known Remote Version
    Given the Remote Version has been flushed
    When I enter "app flush version"
    Then I see "No prior Remote Version found so not flushed."

  Scenario: Clear out the cached Archives
    Given the archive "panickervinod-0.0.1.zip" has been cached
    When I enter "app flush archives"
    Then no archives are cached
    And I see "1 archive(s) flushed"

  Scenario: Clear out the temporary space
    Given the file "res-1.2.0.zip" in temporary storage
    When I enter "app flush temp"
    Then no "res-1.2.0.zip" file is present in temporary storage
    And I see "1 archive(s) flushed"
