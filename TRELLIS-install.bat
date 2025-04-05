@echo off

cd /d "%~dp0"
set START_DIR=%CD%
echo *** The current directory is: %cd%

echo *** Cloning TRELLIS repository
git clone --recurse-submodules https://github.com/microsoft/TRELLIS.git
cd TRELLIS

echo *** Creating venv
py -3.10 -m venv "trellis-venv"
call trellis-venv\scripts\activate.bat

echo *** Upgrading pip, wheel, setuptools
python -m pip install --upgrade pip wheel
python -m pip install setuptools==75.8.2

echo *** Installing requirements
pip install -r %START_DIR%/requirements-torch.txt
pip install -r %START_DIR%/requirements-other.txt

echo *** Set Environment Variables
set ATTN_BACKEND=flash-attn
@REM set ATTN_BACKEND=xformers
set SPCONV_ALGO=native
set XFORMERS_FORCE_DISABLE_TRITON=1

python ./app.py
