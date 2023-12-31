import os
import win32com.client as client

def openapp():
    outlook = client.gencache.EnsureDispatch("Outlook.application")
    return outlook

def openfunc(mod):
    return  dir(mod)

def openOutlook():
    outlook = client.gencache.EnsureDispatch("Outlook.application")
    os.startfile('outlook')
    accounts = outlook.GetNamespace('MAPI')
    folders = accounts.Folders
    for folder in folders:
        print(folder.Name)

# openOutlook()