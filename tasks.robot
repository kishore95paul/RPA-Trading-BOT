*** Settings ***
Documentation       Template robot main suite.

Library    RPA.Browser.Selenium    auto_close=${False}
Library    RPA.Windows
Resource    Testing.robot

*** Tasks ***
Trading Setup
    Browser Setup
    # Testing


*** Keywords ***
Browser Setup
    # Log To Console    Start
    # Windows Run    chrome.exe --remote-debugging-port=9922
    # Sleep    3
    Attach Chrome Browser    9922
    Maximize Browser Window
    Go To    https://kite.zerodha.com/
    Sleep    3
    Input Text    //input[@id="userid"]    HQ6361
    Sleep    2
    Input Password    //input[@id="password"]    Kishore@95
    Sleep    2
    Click Element    //button[@type="submit"]

