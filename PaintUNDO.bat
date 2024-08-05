@echo off
setlocal

:: Set the path to the conda installation dynamically
set "CONDA_PATH=%USERPROFILE%\Miniconda3"

:: Find the directory of this script
set SCRIPT_DIR=%~dp0

:: Change to the directory where Paints-UNDO is installed
cd /d "%SCRIPT_DIR%"

:: Attempt to activate the Paints-UNDO environment and capture any error messages in a file
echo Activating the Paints-UNDO environment...
call "%CONDA_PATH%\Scripts\activate.bat" paints_undo > nul 2>env_error.txt

:: Check the exit status of the previous command to see if the activation was successful
if %ERRORLEVEL% NEQ 0 (
    echo Activation failed. Displaying the error message:
    type env_error.txt
    echo Press any key to exit...
    pause >nul
    goto :eof
) else (
    echo Environment activated successfully.
)

:: Delete the error message file regardless of whether activation was successful
if exist env_error.txt del env_error.txt

:: Start the Paints-UNDO script or application
echo Starting the Paints-UNDO application...
python gradio_app.py

:: Keep the batch file open to show application output
echo Application is running. Press any key to exit...
pause >nul
