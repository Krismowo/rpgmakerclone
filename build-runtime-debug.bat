
cd HazyMaker
lime build windows -debug
robocopy debug\windows\bin ..\debug\windows\bin\assets\runtime /E
cd ..