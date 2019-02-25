# GET /cards/{id}
# author: Mikaela Antezana

@cards @crud
Feature: Cards management GET
  @acceptance @read
  Scenario: Read information of a pre-established card
    Given I have an existing card with parameters
            |   PARAMETER | VALUE               |
            |        name | {organization}      |
            | displayName | example             |
            |        desc | description example |
            |     website | http://example.io   |
    When I send a GET request to /cards/{id}
    Then I get a response status code 200
    And I get a return values


