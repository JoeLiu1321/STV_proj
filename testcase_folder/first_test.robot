*** Setting ***
Library    AppiumLibrary
Library    BuiltIn
Test Setup    On The Calendar Page
Test Teardown    Close Application
# Test Teardown    Run Keywords    Delete Activity    15    TestName
# ...              AND    Close Application
*** Test Cases ***
Create Activity With No Name
    Click Element After Visible    xpath=//android.widget.TextView[contains(@resource-id,'action_add')]
    Click Element After Visible    xpath=//android.widget.Button[contains(@resource-id,'btnOk')]
    Page Should Contain Element    xpath=//android.widget.TextView[@text='請輸入活動名稱。']

Create Activity With Name
    Click Element After Visible    xpath=//android.widget.TextView[@text='15']
    Click Element After Visible    xpath=//android.widget.TextView[contains(@resource-id,'action_add')]
    Input Text After Visible    xpath=//android.widget.EditText[@text='活動名稱']    TestName
    # Press
    Click Element After Visible    xpath=//android.widget.Button[contains(@resource-id,'btnOk')]
    ${activityName} =    Get Text After Visible    xpath=//android.widget.TextView[@text='15']/..//*[contains(@text,'TestName')]
    Should Be Equal    ${activityName}    TestName
    [Teardown]    Run Keywords    Delete Activity    15    TestName
    ...              AND    Close Application

Create Activity click Detail
    Click Element After Visible    xpath=//android.widget.TextView[@text='15']
    Click Element After Visible    xpath=//android.widget.TextView[contains(@resource-id,'action_add')]
    Input Text After Visible    xpath=//android.widget.EditText[@text='活動名稱']    TestName
    # Press
    Click Element After Visible    xpath=//android.widget.Button[contains(@resource-id,'btnMore')]
    Input Text After Visible    xpath=//android.widget.EditText[contains(@resource-id,'txtDescription')]    TestDescription
    Click Element After Visible    xpath=//android.widget.LinearLayout[contains(@resource-id,'action_done')]
    Click Element After Visible    xpath=//android.widget.TextView[@text='15']
    Click Element After Visible    xpath=//android.widget.TextView[contains(@resource-id,'txtContent') and contains(@text,'TestName')]
    ${activityName} =    Get Text After Visible    xpath=//android.widget.TextView[contains(@text,'TestName')]
    Should Be Equal    ${activityName}    TestName
    ${activityDescription} =    Get Text After Visible    xpath=//android.widget.TextView[contains(@text,'TestDescription')]
    Should Be Equal    ${activityDescription}    TestDescription
    Click Element After Visible    xpath=//android.widget.ImageButton[contains(@content-desc,'向上瀏覽')]
    [Teardown]    Run Keywords    Delete Activity    15    TestName
    ...              AND    Close Application

*** Keywords ***
Delete Activity
    [Arguments]    ${date}    ${name}
    Click Element After Visible    xpath=//android.widget.TextView[@text='${date}']
    Click Element After Visible    xpath=//android.widget.TextView[contains(@resource-id,'txtContent') and contains(@text,'${name}')]
    Click Element After Visible    xpath=//android.widget.TextView[contains(@resource-id,'action_remove')]
    Click Element After Visible    xpath=//android.widget.Button[@text='確定']
    Click Element After Visible    xpath=//android.widget.TextView[@text='${date}']
    Page Should Not Contain Element    xpath=//android.widget.TextView[contains(@resource-id,'txtContent') and contains(@text,'${name}')]

On The Calendar Page
    log    ${CURDIR}${/}ContactManager.apk
    Open Application    http://localhost:4723/wd/hub    platformName=Android    platformVersion=9    deviceName=UBV7N18405000195
    ...    appPackage=info.kfsoft.calendar    appActivity=MainActivity    noReset=true

Click Element After Visible
    [Arguments]    ${locator}
    Wait Until Page Contains Element    ${locator}    timeout=3
    Wait Until Element Is Visible    ${locator}    timeout=3
    Click Element    ${locator}

Input Text After Visible
    [Arguments]    ${locator}    ${text}
    Wait Until Page Contains Element    ${locator}    timeout=3
    Wait Until Element Is Visible    ${locator}    timeout=3
    Input Text    ${locator}    ${text}

Get Text After Visible
    [Arguments]    ${locator}
    Wait Until Element Is Visible    ${locator}    timeout=3
    ${activityName} =    Get Text    ${locator}
    [Return]    ${activityName}