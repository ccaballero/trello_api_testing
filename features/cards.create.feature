# POST /cards
# author: Mikaela Antezana

@cards @crud
Feature: Cards management (CREATE)

Parameters definition:
- name: The new name for the card
- desc: Description of the card
- idList: The ID of the list the card should be created in

    @acceptance @create
    Scenario: Create a new card
       Given I have an already created board with parameters
            | PARAMETER | VALUE   |
            |      name | {board} |
       Given I have an already created list with parameters
            | PARAMETER | VALUE             |
            |      name | {list}            |
            |   website | http://example.io |
        When I set the query parameters:
            | QUERY PARAMETER | VALUE               |
            |            name | {card}              |
            |            desc | description example |
            |          idList | {list_id}           |
        And I send a POST request to /cards
        Then I get a response status code 200
