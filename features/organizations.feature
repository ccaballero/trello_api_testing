# /organizations
# author: Carlos E. Caballero B.

@organizations @crud
Feature: Organizations management
Organizations, or as they are referred to in Trello, "Teams", represent
collections of members and boards.

    @acceptance @create
    Scenario: Create a new team
        When I send a POST request to /organizations
         And I set the query params:
            |        name | example             |
            | displayName | example             |
            |        desc | description example |
            |     website | http://example.io   |
        Then I get a response status code 200
         And I get a response header content-type application/json
         And I get a response json based on json schema
        """
        {
            "type":"object",
            "properties":{
                "id":          {"type":"string"},
                "name":        {"type":"string"},
                "displayName": {"type":"string"},
                "desc":        {"type":"string"},
                "url":         {"type":"string"},
                "website":     {"type":"string"}
            },
            "required":["id","name","displayName","desc"]
        }
        """
        And I get a return values:
            |        name | example             |
            | displayName | example             |
            |        desc | description example |
            |     website | http://example.io   |

    @negative @create
    Scenario: Create a new team without mandatory param
        When I send a POST request to /organizations
         And I set the query params:
            | displayName | example             |
            |        desc | description example |
            |     website | http://example.io   |
        Then I get a response status code 400
         And I get a response header content-type text/plain
         And I get a response text
        """
        Display Name must be at least 1 character
        """

