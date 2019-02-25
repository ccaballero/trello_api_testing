# GET /cards/{id}
# author: Mikaela Antezana

@cards @crud
Feature: Cards management GET
    @acceptance @read
    Scenario: Read information of a pre-established card
       Given I have an already created board with parameters
            | PARAMETER | VALUE   |
            |      name | {board} |
       Given I have an already created list with parameters
            | PARAMETER | VALUE             |
            |      name | {list}            |
       Given I have an already created card with parameters
            | QUERY PARAMETER | VALUE               |
            |            name | {card}              |
            |            desc | description example |
       When I send a GET request to /cards/{card_id}
       Then I get a response status code 200

