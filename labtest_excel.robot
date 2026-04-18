*** Settings ***
Library    Library/ExcelLib.py
Library    SeleniumLibrary
Library    String

# Test Setup    Open Browser    url=https://www.bankrate.com/loans/loan-calculator//    browser=chrome

*** Variables ***

*** Test Cases ***
TC001_ExcelTest
    Open Excel    testdata/LoanCalculator.xlsx
    ${aaa}    Read Cell Data    TestData    1    1
    ${bbb}    Read Cell Data By Name    TestData    B1
    Write Cell Data    TestData    2    6    test
    Save Excel
    Close Excel

TC002_ExcelTest
    Open Browser    url=https://www.bankrate.com/loans/loan-calculator/    browser=chrome
    Open Excel    testdata/LoanCalculator.xlsx
    ${total_row}    Get Row Count    TestData
    FOR    ${counter}    IN RANGE    2    ${total_row}    1
        ${checkStatus}    Read Cell Data    TestData    ${counter}    5
        IF    '${checkStatus}' == 'Yes'
            ${loanAmount}    Read Cell Data    TestData    ${counter}    1
            ${termInYears}    Read Cell Data    TestData    ${counter}    2
            ${interestRate}    Read Cell Data    TestData    ${counter}    3
            ${expectResult}    Read Cell Data    TestData    ${counter}    4

            # เว็บเก่า
            # Input Text    //input[@id="loanAmount"]    ${loanAmount}
            # Input Text    //input[@id="termInYears"]    ${termInYears}
            # Input Text    //input[@id="interestRate"]    ${interestRate}
            # Click Element    //button[text()="Calculate"]
            # Wait Until Element Is Visible    //p[@class="Numeral alpha"]
            # ${payment}    Get Text    //p[@class="Numeral alpha"]
            # เว็บใหม่
            Input Text    //input[@id=":r0:"]    ${loanAmount}
            Input Text    //input[@id=":r1:"]    ${termInYears}
            Input Text    //input[@id=":r4:"]    ${interestRate}
            Click Element    //button[text()="Calculate"]
            Wait Until Element Is Visible    //div[@class="text-4xl font-bold mb-6 leading-tight"]
            ${payment}    Get Text    //div[@class="text-4xl font-bold mb-6 leading-tight"]
            ${result1}    Remove String    ${payment}    $
            ${result2}    Remove String    ${result1}    ,
            ${result3}    Strip String    ${result2}
            ${result3}    Convert To Number    ${result3}
            IF    ${expectResult} == ${result3} 
                ${status}    Set Variable    Pass
            ELSE
                ${status}    Set Variable    Fail
            END
            ${result3}    Convert To String    ${result3}
            Write Cell Data    TestData    ${counter}    6    ${result3}
            Write Cell Data    TestData    ${counter}    7    ${status}
        END
    END

    Save Excel
    Close Excel
    

*** Keywords ***

    
    