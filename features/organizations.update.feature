# PUT /organizations/{id}
# author: Carlos E. Caballero B.

@organizations @crud
Feature: Organizations management (UPDATE)
Organizations, or as they are referred to in Trello, "Teams", represent
collections of members and boards.

Parameters definition:

- id: mandatory parameter
- name: A new name for the organization. At least 3 lowercase letters,
        underscores, and numbers. Must be unique
- displayName: A new displayName for the organization. Must be at least 1
        character long and not begin or end with a space.
- desc: A new description for the organization
- website: A URL starting with http://, https://, or null
- prefs/associatedDomain: The Google Apps domain to link this org to.
- prefs/externalMembersDisabled: Whether non-team members can be added to
        boards inside the team
- prefs/googleAppsVersion: 1 or 2
- prefs/boardVisibilityRestrict/org: Who on the team can make team visible
        boards. One of admin, none, org
- prefs/boardVisibilityRestrict/private: Who can make private boards. One of:
        admin, none, org
- prefs/boardVisibilityRestrict/public: Who on the team can make public boards.
        One of: admin, none, org
- prefs/orgInviteRestrict: An email address with optional wildcard characters.
        (E.g. subdomain.*.trello.com)
- prefs/permissionLevel: Whether the team page is publicly visible. One of:
        private, public

This method lets you update one or more properties of the organization in a
    single request.

It is also possible to update a single property:

    PUT /1/organizations/{id}/{property}?value={new value}

So for example, to update just the displayName for an org you could also do:

    PUT /1/organizations/{id}/displayName?value=Awesome%20Team

    @acceptance @update
    Scenario: Update information of a pre-established organization
       Given I have an existing organization with parameters
            |   PARAMETER | VALUE               |
            |        name | {organization}      |
            | displayName | example             |
            |        desc | description example |
            |     website | http://example.io   |
        When I set the query parameters:
            | QUERY PARAMETER | VALUE                   |
            |            name | {new_organization}      |
            |     displayName | new_example             |
            |            desc | description new example |
            |         website | http://new.example.io   |
         And I send a PUT request to /organizations/{id}
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
            | JSON PROPERTY | VALUE                                 |
            |          name | {new_organization}                    |
            |   displayName | new_example                           |
            |          desc | description new example               |
            |           url | https://trello.com/{new_organization} |
            |       website | http://new.example.io                 |

    @acceptance @update
    Scenario: Update information of a single property name in pre-established
        organization
       Given I have an existing organization with parameters
            |   PARAMETER | VALUE               |
            |        name | {organization}      |
            | displayName | example             |
            |        desc | description example |
            |     website | http://example.io   |
        When I set the query parameters:
            | QUERY PARAMETER | VALUE                   |
            |           value | {new_organization}      |
         And I send a PUT request to /organizations/{id}/name
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
            | JSON PROPERTY | VALUE                                 |
            |          name | {new_organization}                    |
            |   displayName | example                               |
            |          desc | description example                   |
            |           url | https://trello.com/{new_organization} |
            |       website | http://example.io                     |

    @acceptance @update
    Scenario: Update information of a single property displayName in
        pre-established organization
       Given I have an existing organization with parameters
            |   PARAMETER | VALUE               |
            |        name | {organization}      |
            | displayName | example             |
            |        desc | description example |
            |     website | http://example.io   |
        When I set the query parameters:
            | QUERY PARAMETER | VALUE       |
            |           value | new_example |
         And I send a PUT request to /organizations/{id}/displayName
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
            | JSON PROPERTY | VALUE                             |
            |          name | {organization}                    |
            |   displayName | new_example                       |
            |          desc | description example               |
            |           url | https://trello.com/{organization} |
            |       website | http://example.io                 |

    @negative @update
    Scenario: Update information of an organization with parameter name with 1
        characters
       Given I have an existing organization with parameters
            |   PARAMETER | VALUE               |
            |        name | {organization}      |
            | displayName | example             |
            |        desc | description example |
            |     website | http://example.io   |
        When I set the query parameters:
            | QUERY PARAMETER | VALUE                   |
            |            name | e                       |
            |     displayName | new_example             |
            |            desc | description new example |
            |         website | http://new.example.io   |
         And I send a PUT request to /organizations/{id}
        Then I get a response status code 400
         And I get a response header content-type text/plain
         And I get a response text
        """
        Organization short name must be at least 3 characters
        """

    @negative @update
    Scenario: Update information of an organization with parameter name with
        uppercase characters
       Given I have an existing organization with parameters
            |   PARAMETER | VALUE               |
            |        name | {organization}      |
            | displayName | example             |
            |        desc | description example |
            |     website | http://example.io   |
        When I set the query parameters:
            | QUERY PARAMETER | VALUE               |
            |            name | EXAMPLE             |
            |     displayName | new_example         |
            |            desc | description example |
            |         website | http://example.io   |
         And I send a PUT request to /organizations/{id}
        Then I get a response status code 400
         And I get a response header content-type text/plain
         And I get a response text
        """
        Organization short name is invalid: only lowercase letters, underscores, and numbers are allowed
        """

    @negative @update
    Scenario: Update information of an organization with parameter name with
        special characters
       Given I have an existing organization with parameters
            |   PARAMETER | VALUE               |
            |        name | {organization}      |
            | displayName | example             |
            |        desc | description example |
            |     website | http://example.io   |
        When I set the query parameters:
            | QUERY PARAMETER | VALUE               |
            |            name | $example            |
            |     displayName | new_example         |
            |            desc | description example |
            |         website | http://example.io   |
         And I send a PUT request to /organizations/{id}
        Then I get a response status code 400
         And I get a response header content-type text/plain
         And I get a response text
        """
        Organization short name is invalid: only lowercase letters, underscores, and numbers are allowed
        """

    @negative @update
    Scenario: Update information of an organization with parameter displayName
        with 0 characters
       Given I have an existing organization with parameters
            |   PARAMETER | VALUE               |
            |        name | {organization}      |
            | displayName | example             |
            |        desc | description example |
            |     website | http://example.io   |
        When I set the query parameters:
            | QUERY PARAMETER | VALUE                   |
            |            name | example                 |
            |     displayName |                         |
            |            desc | description new example |
            |         website | http://new.example.io   |
         And I send a PUT request to /organizations/{id}
        Then I get a response status code 400
         And I get a response header content-type text/plain
         And I get a response text
        """
        Display Name must be at least 1 character
        """

