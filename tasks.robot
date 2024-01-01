*** Settings ***
Documentation       Template robot main suite.

Library    RPA.Browser.Selenium    auto_close=${False}
Resource    Resources/Browser.robot
Resource    Resources/Read Data.robot

*** Tasks ***
Trading Setup
    # Browser Setup
    # Download data
    Read CSV Data

    # Testing
