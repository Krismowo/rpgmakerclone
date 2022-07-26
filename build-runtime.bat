@echo off

cd HazyMaker
lime build windows -release
robocopy release\windows\bin ..\release\windows\bin\assets\runtime /E
cd ..

@echo on