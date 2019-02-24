# /organizations
# author: Carlos E. Caballero B.

@organizations @crud
Feature: Organizations management (CREATE)
Organizations, or as they are referred to in Trello, "Teams", represent
collections of members and boards.

Parameters definition:

- displayName: mandatory parameter
- desc: The description for the team
- name: A string with a length of at least 3. Only lowercase letters,
-     underscores, and numbers are allowed. Must be unique.
- website: A URL starting with http:// or https://

    @acceptance @create
    Scenario: Create a new team
        When I set the query parameters:
            |        name | example             |
            | displayName | example             |
            |        desc | description example |
            |     website | http://example.io   |
         And I send a POST request to /organizations
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
    Scenario: Create a new team without mandatory param displayName
        When I set the query parameters:
            |        name | example             |
            |        desc | description example |
            |     website | http://example.io   |
         And I send a POST request to /organizations
        Then I get a response status code 400
         And I get a response header content-type text/plain
         And I get a response text
        """
        Display Name must be at least 1 character
        """
 
    @negative @create
    Scenario: Create a new team with param name with 1 characters
        When I set the query parameters:
            |        name | e                   |
            |        desc | description example |
            |     website | http://example.io   |
         And I send a POST request to /organizations
        Then I get a response status code 400
         And I get a response header content-type text/plain
         And I get a response text
        """
        Display Name must be at least 1 character
        """
 
    @negative @create
    Scenario: Create a new team with param name with uppercase characters
        When I set the query parameters:
            |        name | EXAMPLE             |
            |        desc | description example |
            |     website | http://example.io   |
         And I send a POST request to /organizations
        Then I get a response status code 400
         And I get a response header content-type text/plain
         And I get a response text
        """
        Display Name must be at least 1 character
        """
 
    @negative @create
    Scenario: Create a new team with param name with special characters
        When I set the query parameters:
            |        name | $example            |
            |        desc | description example |
            |     website | http://example.io   |
         And I send a POST request to /organizations
        Then I get a response status code 400
         And I get a response header content-type text/plain
         And I get a response text
        """
        Display Name must be at least 1 character
        """

    @negative @create
    Scenario: Create a new team with param website without protocol
        When I set the query parameters:
            |        name | $example            |
            |        desc | description example |
            |     website | example.io          |
         And I send a POST request to /organizations
        Then I get a response status code 400
         And I get a response header content-type text/plain
         And I get a response text
        """
        Display Name must be at least 1 character
        """

