# author: Mary Luna
@lists @crud
Feature: Create board

  @acceptance @create
  Scenario: Create board by id
    When I set the query parameters:
      | QUERY PARAMETER | VALUE   |
      | name            | {board} |
    And I send a POST request to /boards
    Then I get a response status code 200
    And I get a response header content-type application/json
    And I get a response json based on json schema
    """
    {
        "type":"object",
        "properties":{
          "id":{"type":"string"},
          "name":{"type":"string"}          
        },
        "required":["id","name"]
    }
    """
    And I get a return values:
      | JSON PROPERTY | VALUE   |
      | name          | {board} |

