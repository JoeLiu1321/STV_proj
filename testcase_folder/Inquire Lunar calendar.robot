*** Setting ***
Library    AppiumLibrary
Library    BuiltIn
Library    Dialogs
Resource    ./Keywords.txt
Test Setup    On The Calendar Page
Test Teardown    Close Application

*** Test Cases ***
TC-14 Inquire Lunar Calendar
    ${day} =    Set Variable    15
    Change Mode    月
    Select Day    ${day}
    Click Element After Visible    xpath=//*[contains(@resource-id,'txtCanDo') or contains(@resource-id,'txtCannotDo')]/..
    ${lunarDate} =    Get Text After Visible    xpath=//*[contains(@resource-id,'tvLunarDate')]
    Should Contain    ${lunarDate}    五月十三日
    # Pause Execution