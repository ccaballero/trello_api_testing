# author: Ubaldo Villaseca

@crud
Feature: Get lists

  @acceptance @read
  Scenario: Get list by id
    Given I have an existing board
      And I have an existing list
    When I send a GET request to /lists/{list_id}
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
          "required":["id","name","closed","idBoard", "pos"]
      }
      """