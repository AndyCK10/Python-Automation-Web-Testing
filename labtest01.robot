*** Settings ***

*** Variables ***
${a}    10
@{array1}    Data1    Data2    Data3
&{diction1}    first=DataDict1    second=DataDict2    third=DataDict3
*** Test Cases ***
TC001_Demo1
    ${b}    Set Variable    5
    ${c}    Evaluate    ${a}+${b}
    ${d}    Evaluate    ${a}-${b}
    ${e}    Evaluate    ${a}*${b}
    ${f}    Evaluate    ${a}/${b}
    
    Log    Result = ${c} 
    Log    Result = ${d} 
    Log    Result = ${e} 
    Log    Result = ${f} 

    Set Global Variable    ${c_global}    ${c}
    Set Global Variable    ${e_global}    ${e}

TC002_Demo2
    Log    ${a}
    Log    ${c_global}
    Log    ${e_global}

TC003_Demo3
    ${data_array_1}    Set Variable    ${array1}[0]
    Log    ${array1}
    Log    ${data_array_1}
TC004_Demo4
    Log    ${diction1}
    Log    ${diction1.first}
    Log    ${diction1}[first]
    
TC005_Demo5
    ${a}    Set Variable    50
    ${b}    Set Variable    3
    ${actual}    Evaluate    ${a}+${b}
    ${expected}    Set Variable    55
    IF    '${actual}' == '${expected}'
        Log    Test Pass
    ELSE
        Fail    Test Failed
    END

TC006_Demo6

    FOR    ${counter}    IN RANGE    1    11    1
        Log    ${counter}
        Exit For Loop If    ${counter}==5
    END
    
*** Keywords ***