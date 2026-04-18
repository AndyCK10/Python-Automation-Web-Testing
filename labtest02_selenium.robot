*** Settings ***
Library    SeleniumLibrary

# Suite Setup    Open Browser    url=https://www.calculator.net/gas-mileage-calculator.html    browser=chrome
Test Setup    Open Browser    url=https://www.calculator.net/gas-mileage-calculator.html    browser=chrome

# Suite Teardown    Log    EndTest
Test Teardown    Log    EndTest

*** Variables ***

*** Test Cases ***
# TC001_Google_Test
#     Open Browser    url=https://www.google.com/    browser=chrome
#     Sleep    1
#     Input Text    //textarea[@name="q"]    blackpink
#     Sleep    1
#     Click Element    (//input[@name="btnK"])[2]
#     Sleep    5

TC002_Gasmileage
    [Tags]    UAT    Regression
    Wait Until Element Is Visible    //input[@id="mucodreading"]    timeout=10
    Input_Value_To_Gasmileage    15000    10000    15    5
    Click_Action_Get_And_Result

TC003_Gasmileage
    [Tags]    SIT    Functional
    Wait Until Element Is Visible    //input[@id="mucodreading"]    timeout=10
    Input_Value_To_Gasmileage    20000    15000    15    5
    Click_Action_Get_And_Result

*** Keywords ***
Input_Value_To_Gasmileage
    [Arguments]    ${mucodreading}    ${mupodreading}    ${mugasputin}    ${mugasprice}
    Input Text    //input[@id="mucodreading"]    ${mucodreading}
    Input Text    //input[@id="mupodreading"]    ${mupodreading}
    Input Text    //input[@id="mugasputin"]    ${mugasputin}
    Input Text    //input[@id="mugasprice"]    ${mugasprice}

Click_Action_Get_And_Result
    Click Element    (//input[@name="x"])[2]
    Wait Until Element Is Visible    //p[@class="verybigtext"]/font
    ${result}    Get Text    //p[@class="verybigtext"]/font
    Log To Console   ${result} 