Feature: Generate Token Real

  Scenario: Generate Token
    Given url "https://tek-insurance-api.azurewebsites.net"
    And path "/api/token"
    And request {"username": "supervisor", "password":"tek_supervisor"}
    And method post
    Then status 200
    And print response
