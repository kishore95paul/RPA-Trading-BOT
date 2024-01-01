*** Settings ***
Documentation    Read CSV Data
Library    RPA.FileSystem
Library    DateTime
Library    RPA.Tables
Library    String


*** Variables ***
${download_directory}    C:\\Users\\kisho\\Downloads


*** Tasks ***
# *** Keywords ***
Read CSV Data
    ${date}=    Get Current Date    result_format=%d-%b-%Y
    Create Directory    path=..\\Result    exist_ok=${True}
    Create File    path=..\\Result\\Total Market Data - ${date}.csv
    ...    content=SYMBOL,OPEN,HIGH,LOW,PREV. CLOSE,LTP,CHNG,%CHNG,VOLUME (shares),VALUE,52W H,52W L,30 D %CHNG,365 D %CHNG\n
    ...    encoding=utf-8
    ...    overwrite=${True}
    WHILE    $True
        Sleep    5
        ${fileExist}=    Does File Exist    ${download_directory}\\MW-NIFTY-TOTAL-MARKET-${date}.csv
        IF    $fileExist
            Log To Console    File Found
            BREAK
        ELSE
            Log To Console    Looking for File ....
            CONTINUE
        END
    END
    ${MarketDataTable}=    Read table from CSV    path=${download_directory}\\MW-NIFTY-TOTAL-MARKET-${date}.csv    header=${False}
    Log    ${MarketDataTable}
    ${MarketDataTableDimension}=    Get Table Dimensions    ${MarketDataTable}
    FOR    ${rowCounter}    IN RANGE    15    ${MarketDataTableDimension[0]}
        ${row}=    Set Variable    ${MarketDataTable[${rowCounter}]}
        FOR    ${ele}    IN    ${row[0]}
            # ${ele}=    Replace String    ${ele}    "    ${EMPTY}
            Append To File    path=..\\Result\\Total Market Data - ${date}.csv    content=${ele}\n    encoding=utf-8
        END
    END
    ${TotalMarketDataTable}=    Read table from CSV    path=..\\Result\\Total Market Data - ${date}.csv    header=${True}
    ${TotalMarketDataTableDimension}=    Get Table Dimensions    ${TotalMarketDataTable}
    FOR    ${row}    IN RANGE    ${TotalMarketDataTableDimension[0]}
        FOR    ${col}    IN RANGE    1    ${TotalMarketDataTableDimension[1]}
            ${ele}=    Get Table Cell    ${TotalMarketDataTable}    ${row}    ${col}
            ${ele}=    Replace String    ${ele}    ,    ${EMPTY}
            TRY
                ${ele}=    Convert To Number    ${ele}
            EXCEPT    AS    ${message}
                Log    ${message}
                No Operation
            END
            Set Table Cell    ${TotalMarketDataTable}    ${row}    ${col}    ${ele}            
        END        
    END
    Write table to CSV    ${TotalMarketDataTable}    path=..\\Result\\Total Market Data - ${date}.csv
    ${LTP500Less}=    Find Table Rows    ${TotalMarketDataTable}    LTP    <    500
    Sort Table By Column    ${LTP500Less}    30 D %CHNG
    Write table to CSV    ${LTP500Less}    path=
    # ${SortedMarketData}=    Sort Table By Column    ${MarketDataTable}    column
