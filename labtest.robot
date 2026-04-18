*** Settings ***

*** Variables ***
${a}    10
@{array1}    Data1    Data2    Data3
&{diction1}    first=DataDic1    second=DataDict2    third=DataDict3

*** Test Cases ***
TC001_Demo1
    Log To Console    Hello
    Log To Console    World

    Log    Hello1
    Log    World1

    ${b} =    Set Variable    World
    ${c} =    Set Variable    ${a} ${b}
    Log To Console    ${c}


    ${b} =    Set Variable    5
    ${c} =    Evaluate    ${a}+${b}
    ${d} =    Evaluate    ${a}-${b}
    ${e} =    Evaluate    ${a}*${b}
    ${f} =    Evaluate    ${a}/${b}

    ${c_test} =    Set Variable    Result = ${c}

    Log    ${c_test}
    Log    Result = ${d}
    Log    Result = ${e}
    Log    Result = ${f}

    Set Global Variable    ${c_global}    ${c}


TC002_Demo2
    Log    ${a}
    Log    ${c_global}

TC003_Demo3
    ${data_array_1} =    Set Variable    ${array1}

    Log    ${array1}
    Log    ${array1}[0]
    Log    ${array1}[1]
    Log    ${array1}[2]
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
    # ELSE IF    '${actual}' == '${expected}'
    #     IF    '${actual}' == '${expected}'
    #         Log    Test Pass
    #     ELSE
            
    #     END
    # END
    ELSE
        Fail    Test Failed
    END

TC006_Demo6
    FOR    ${counter}    IN RANGE    1    11    1
        Log    ${counter}
        Exit For Loop If    ${counter}==5
    END

*** Keywords ***