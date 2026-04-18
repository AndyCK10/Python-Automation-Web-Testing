*** Settings ***
Library    SeleniumLibrary

Test Setup    Open Browser    url=https://www.calculator.net/gas-mileage-calculator.html/    browser=chrome

*** Variables ***

*** Test Cases ***
TC001_Google_Test
    Open Browser    url=https://www.google.com/    browser=chrome
    Sleep    5
    Input Text    //textarea[@name="q"]    packping
    Click Element    (//textarea[@name="q"])
    Sleep    5
TC002_Gasmileage_Test
    [Tags]    UAT
    Wait Until Element Is Visible    //input[@id="mucodreading"]    timeout=10
    Input_Value_To_Gasmileage    20000    15000    15    5
    Click_Action_Get_And_Result
    
    # Click Element    (//input[@name="x"]) [2]
    # ${result}    Get Text    //p[@class="verybigtext"]/font
    # Log    To    Console    ${result}

TC003_Gasmileage_Test
    [Tags]    SIT
    Wait Until Element Is Visible    //input[@id="mucodreading"]    timeout=10
    Input_Value_To_Gasmileage    20000    15000    15    5
    Click_Action_Get_And_Result

*** Keywords ***
Input_Value_To_Gasmileage
    [Arguments]    ${mu}    ${mup}    ${tin}    ${price}
    Input Text    //input[@id="mucodreading"]    ${mu}
    Input Text    //input[@id="mupodreading"]    ${mup}
    Input Text    //input[@id="mugasputin"]    ${tin}
    Input Text    //input[@id="mugasprice"]    ${price}

Click_Action_Get_And_Result
    Click Element    (//input[@name="x"]) [2]
    Wait Until Element Is Visible    //p[@class="verybigtext"]/font
    ${result}    Get Text    //p[@class="verybigtext"]/font
    Log    To    Console    ${result}

TC004_Google_ANDY
    Go To    https://www.google.com/
    Wait Until Element Is Visible    //textarea[@name="q"]    timeout=10
    Input Text    //textarea[@name="q"]    packping
    Press Keys    //textarea[@name="q"]    RETURN
    Wait Until Element Is Visible    //h3    timeout=10
    Close Browser