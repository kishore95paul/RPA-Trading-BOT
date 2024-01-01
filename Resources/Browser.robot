*** Settings ***
Library    RPA.Windows
Library    RPA.Browser.Selenium
Library    RPA.FileSystem
Library    DateTime

*** Variables ***
${download_directory}    C:\\Users\\kisho\\Downloads

*** Keywords ***
Browser Setup
    Log To Console    Start
    Windows Run    chrome.exe --remote-debugging-port=9922
    Sleep    3
    Attach Chrome Browser    9922
    Maximize Browser Window

Download data
    ${date}=    Get Current Date    result_format=%d-%b-%Y
    Go To    https://www.nseindia.com/market-data/live-equity-market
    Wait Until Page Contains Element    //table[@id="equityStockTable"]
    Wait Until Page Contains Element    //option[text()='NIFTY TOTAL MARKET']
    Wait Until Keyword Succeeds    10x    2s    Click Element    //option[text()='NIFTY TOTAL MARKET']
    Wait Until Page Contains Element    //table[@id="equityStockTable"]
    ${fileExist}=    Does File Exist    ${download_directory}\\MW-NIFTY-TOTAL-MARKET-${date}.csv
    IF    $fileExist
        Log To Console    File Already Exist. Moving Ahead
    ELSE
        Wait Until Keyword Succeeds    10x    2s    Click Element    //span[@id="dwldcsv"]
    END
    