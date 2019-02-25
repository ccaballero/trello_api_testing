# author: Mary Luna
@lists @crud
Feature: Create board

  @acceptance @create
  Scenario: Create list by id
    When I set the query parameters:
      | QUERY PARAMETER | VALUE   |
      | name            | {board} |
    And I send a POST request to /boards
    Then I get a response status code 200
    And I get a response header content-type application/json
    And I get a response json based on json schema
      """
      {
    "id": "5c742160c0ea2e0f467732f4",
    "name": "NewBoardAPITEST",
    "desc": "",
    "descData": null,
    }
      """
    And I get a return values:
      | JSON PROPERTY | VALUE   |
      | name          | {board} |

