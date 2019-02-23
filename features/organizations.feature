# /organizations
# author: Carlos E. Caballero B.

@crud
Feature: Organizations management
Organizations, or as they are referred to in Trello, "Teams", represent
collections of members and boards.

    @acceptance @create
    Scenario: Create a new team
        When I send a POST request to /organizations
        And I set the query params:
            | displayName | example             |
            |        desc | description example |
            |        name | example             |
            |     website | http://example.io   |
        Then I get a response status code 200
         And I get a response json based on json schema
        """
        {
            "type":"object",
            "properties":{
                "id":{type:"objectid"},
                "name":{type:"string"},
                "displayName":{type:"string"},
                "desc":{type:"string"},
                "url":{type:"string"},
                "website":{type:"string"}
            },
            "required":["id","name","displayName","desc"]
        }
        """

