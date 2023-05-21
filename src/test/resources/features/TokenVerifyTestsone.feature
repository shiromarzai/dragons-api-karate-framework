#Scenario 5:
#endpoint = /api/token/verify
#With a valid token you should get response HTTP Status Code 200 and response true
@Smoke @Regression
Feature: Token Verify Test

  Background: Setup URl for test
    Given url "https://tek-insurance-api.azurewebsites.net"

  Scenario: Verify valid token
    And path "/api/token"
    And request {"username": "supervisor", "password":"tek_supervisor"}
    And method post
    Then status 200
    And print response
    Given path "/api/token/verify"
    And param token = response.token
    And param username = "supervisor"
    When method get
    Then status 200
    And print response
    And assert response == "true"
    
#Scenario 6:  
#Endpoint = /api/token/verify 
#With valid token and invalid username you should get response HTTP Status Code 400  
#and error message "Wrong Username send along with Token" 

Scenario: Negative Test Validate token with wrong username 
And path "/api/token"
    And request {"username": "supervisor", "password":"tek_supervisor"}
    And method post
    Then status 200
    And print response
Given path "/api/token/verify"
And param token = response.token
And param username = "someone"
When method get
Then status 400
And print response
And assert response.errorMessage == "Wrong Username send along with Token"


#Scenario 7:  

#Endpoint = /api/token/verify 
#with invalid token and valid username 
#should have Status code 400 and error Message "Token Expired or Invalid Token" 
Scenario: Validate Token With invalid Token and valid username
And path "/api/token/verify"
And param token = "somthing" 
And param username = "supervisor"
When method get
Then status 400
And print response
And assert response.errorMessage == "Token Expired or Invalid Token"


