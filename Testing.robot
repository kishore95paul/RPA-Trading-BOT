*** Settings ***
Library    RPA.Outlook.Application
Library    Collections
Library    test.py
Library    Dialogs
Library    DateTime

*** Tasks ***
Testing
    FOR    ${counter}    IN RANGE    10    0
        Log To Console    ${counter - 1}
        
    END
    