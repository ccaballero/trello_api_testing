# GET /cards/{id}
# author: Mikaela Antezana

@cards @crud
Feature: Cards management GET
  @acceptance @read
  Scenario: Read information of a pre-established card
    Given I have an already created card with parameters
            | QUERY PARAMETER | VALUE               |
            |            name | {card}              |
            |            desc | description example |
            |          idList | {list_id}           |
    When I send a GET request to /cards/{id}
    Then I get a response status code 200



