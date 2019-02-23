@crud
Feature: CRUD lists

  @create @acceptance
  Scenario: Create list
    Given I have an existing board
    When I send a POST request to /lists with name myName
    Then I get a resp0nse with  HTTP status code 200
      And with valid b0dy
        """
        {
            "type":"object",
            "properties":{
                "id":{type:"string"},
                "name":{type:"string"},
                "closed":{type:"boolean"},
                "idBoard":{type:"string"},
                "pos":{type:"integer"},
                "limits":{type:"array"}
            },
            "required":["id","name","closed","idBoard", "pos", "limits"]
        }
        """
    