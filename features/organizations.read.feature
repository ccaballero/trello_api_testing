# /organizations
# author: Carlos E. Caballero B.

@organizations @crud
Feature: Organizations management (READ)
Organizations, or as they are referred to in Trello, "Teams", represent
collections of members and boards.

Parameters definition:

- id: mandatory parameter

    @acceptance @read
    Scenario: Read information of a pre-established organization
       Given I have an existing organization with parameters
            |        name | example             |
            | displayName | example             |
            |        desc | description example |
            |     website | http://example.io   |
        When I send a GET request to /organizations/{id}
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
            "required":["id","name","displayName","desc","url","website"]
        }
        """
         And I get a return values:
            |        name | example             |
            | displayName | example             |
            |        desc | description example |
            |     website | http://example.io   |

    @negative @read
    Scenario: Read information from a nonexistent resource
        When I send a GET request to /organization/nonexistent
        Then I get a response status code 404
         And I get a response header content-type text/plain
         And I get a response text
        """
        model not found
        """

