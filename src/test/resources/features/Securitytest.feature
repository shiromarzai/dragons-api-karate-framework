@Smoke @Regression
Feature: API Test Security Section

  Background: Setup URl
    Given url "https://tek-insurance-api.azurewebsites.net"
    And path "/api/token"

  Scenario: Create a Token With Valid username and PAssword
    #prepare request
    And request {"username":"supervisor","password":"tek_supervisor"}
    #send request
    When method post
    #validating request
    Then status 200
    And print response

  # Scenario 1:
  #endpoint = /api/token
  #if you send wrong username you should get 400 Status code
  #and API Response message "User not found"
  Scenario: Validate Token with invalid username
    And request {"username": "somone","password":"tek_supervisor"}
    When method post
    Then status 400
    And print response
    And assert response.errorMessage == "User not found"
    And assert response.httpStatus == "BAD_REQUEST"
    And assert response.errorCode == "USER_NOT_FOUND"

  #Scenario 2
  #endpoint = /api/token
  #if you send correct username and wrong password,
  # you should see 400 Bad Request and errorMessage Password not match
  Scenario: Validate Token with correct usernmae and invalid password
    And request {"username": "supervisor", "password": "somepass"}
    When method post
    Then status 400
    And print response
    And assert response.errorCode == "WRONG_PASSWORD"
    And assert response.httpStatus == "BAD_REQUEST"
    And assert response.errorMessage == "Password Not Matched"
