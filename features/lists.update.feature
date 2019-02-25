# author: Ubaldo Villaseca

@crud
Feature: Update lists

  @acceptance @update
  Scenario: Update list by id
    Given I have an existing board
      And I have an existing list
    When I set the query parameters:
      | QUERY PARAMETER | VALUE       |
      |            name | {updated_list}      |
      And I send a PUT request to /lists/{list_id}
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
      And I get a return values:
        | JSON PROPERTY | VALUE  |
        |          name | {updated_list} |
    
    @acceptance @update
    Scenario: Close list by id
      Given I have an existing board
        And I have an existing list
      When I send a PUT request to /lists/{list_id}/closed?value=true
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
                "pos":{"type":"integer"}                
            },
            "required":["id","name","closed","idBoard", "pos"]
        }
        """
        And I get a return values:
          | JSON PROPERTY | VALUE |
          |        closed | True  |