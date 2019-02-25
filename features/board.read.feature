# author: Mary Luna
# GET /board/{id}

@acceptance @crud
Feature: Board management GET

  @acceptance @read
  Scenario: Read information of a pre-established board
    Given I have an existing board with parameters
      | PARAMETER   | VALUE        |
      | id        | {board}      |

    When I send a GET request to /boards/{id}
    Then I get a response status code 200
    And I get a return values