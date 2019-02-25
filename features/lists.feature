# author: Ubaldo Villaseca

@crud
Feature: CRUD lists

  @create @acceptance
  Scenario: Create list
    Given I have an existing board
    When I set the query parameters:
      | QUERY PARAMETER | VALUE       |
      |            name | {list}      |    
      And I send a POST request to /lists?idBoard={id}
    Then I get a response status code 200
      And I get a response header content-type application/json
      And I get a response json based on json schema
      """
      {
          "type":"object",
          "properties":{
              "id":{"type":"string"},
              "name":{"type":"string"},
              "closed":{"type":"boolean"},
              "idBoard":{"type":"string"},
              "pos":{"type":"integer"},
              "limits":{"type":"object"}
          },
          "required":["id","name","closed","idBoard", "pos", "limits"]
      }
      """
      And I get a return values:
        | JSON PROPERTY | VALUE  |
        |          name | {list} |