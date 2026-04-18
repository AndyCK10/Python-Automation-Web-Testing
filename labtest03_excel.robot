*** Settings ***
Library    library/ExcelLib.py
Library    SeleniumLibrary
Library    String

*** Variables ***

*** Test Cases ***
TC001_ExcelTest
    Open Excel    testdata/LoanCalculator.xlsx
    ${aaa}    Read Cell Data    TestData    2    1
    Write Cell Data    TestData    2    6    test
    Save Excel
    Close Excel

TC002_LoanCalculator
    Open Browser    https://www.bankrate.com/calculators/mortgages/loan-calculator.aspx    chrome
    Open Excel    testdata/LoanCalculator.xlsx
    ${total_row}    Get Row Count    TestData
    FOR    ${counter}    IN RANGE    2    151    1
        ${LoanAmount}    Read Cell Data    TestData    ${counter}    1
        ${LoanTermInYear}    Read Cell Data    TestData   ${counter}    2
        ${InterestRatePerYear}    Read Cell Data    TestData    ${counter}    3
        ${expected}    Read Cell Data    TestData    ${counter}    4
        ${expected}    Convert To Number    ${expected}
        ${run_status}    Read Cell Data    TestData    ${counter}     5
        IF    '${run_status}' == 'Yes'
            # เว็บเก่า
            # Input Text    //input[@id="loanAmount"]     ${LoanAmount}
            # Input Text    //input[@id="termInYears"]    ${LoanTermInYear}
            # Input Text    //input[@id="interestRate"]    ${InterestRatePerYear}
            # Click Element    //button[text()=" Calculate "]
            # Wait Until Element Is Visible    //p[@class="Numeral alpha"]
            # ${monthly_payment}    Get Text    //p[@class="Numeral alpha"]
            # เว็บใหม่
            Input Text    //input[@id=":r0:"]     ${LoanAmount}
            Input Text    //input[@id=":r1:"]    ${LoanTermInYear}
            Input Text    //input[@id=":r4:"]    ${InterestRatePerYear}
            Click Element    //button[text()="Calculate"]
            Wait Until Element Is Visible    //div[@class="text-4xl font-bold mb-6 leading-tight"]
            ${monthly_payment}    Get Text    //div[@class="text-4xl font-bold mb-6 leading-tight"]
            ${result1}    Remove String     ${monthly_payment}    $
            ${result2}    Remove String     ${result1}    ,
            ${result3}    Strip String    ${result2}
            ${result3}    Convert To Number    ${result3}
            IF    ${expected} == ${result3}
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