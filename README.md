# TRELLIS-install-windows
Install instructions for a working build of [TRELLIS](https://github.com/microsoft/TRELLIS) on Windows Operating system. Tested with Windows 11, Python 3.10, CUDA 12.4, and VS Build Tools 2022.

## Inspiration
These instructions were a culmination of resources including [TRELLIS/setup.sh](https://github.com/microsoft/TRELLIS/blob/main/setup.sh), [TRELLIS/Issues/3](https://github.com/microsoft/TRELLIS/issues/3), and [sdbds/TRELLIS-for-Windows](https://github.com/sdbds/TRELLIS-for-windows?tab=License-1-ov-file).

## Issues and Resolutions
###### Conda
**`Issue:`** Conda licenses have changed and to ensure that we are not violating the Enterprise (company more than 200 employees) licensing limitation I selected a solution not using conda.</br>
**`Solution:`** Use Python venv instead.

###### Python Wheels won't build
**`Issue:`** Python installation or venv does not include the Python build libraries (Python.h).</br>
**`Solution:`** Ensure that the Python build you are using includes the Python.h. On non-windows this is included in python-dev, but this is not supported on Windows. The standard `Windows installer (xxxxx)` builds include this, but the `Windows embeddable pakage (xxxxx)` does not. Verify that your install includes `Python###\include\Python.h`.</br></br>

**`Issue:`** File "subprocess.py", line 526, in run subprocess.CalledProcessError: Command '['ninja', '-v']' returned non-zero exit status 1.</br>
**`Solution:`** Ensure you are using `setuptools==75.8.2`.</br></br>

**`Issue:`** I don't know the minimum Visual Studio needed to build.</br>
**`Solution:`** Ensure you are using `Desktop development with C++`.

###### Gradio won't launch
**`Issue:`** Trying to run app.py throws `ERROR: Exception in ASGI application`.</br>
**`Solution:`** Ensure you are using `pydantic==2.10.6`.

# Successful Build
## Prerequistes
[Build Tools for Visual Studio 2022](https://visualstudio.microsoft.com/downloads/?q=build+tools#build-tools-for-visual-studio-2022)</br>
[CUDA 12.4](https://developer.nvidia.com/cuda-12-4-0-download-archive?target_os=Windows&target_arch=x86_64&target_version=11&target_type=exe_local)</br>
[Python 3.10.11](https://www.python.org/downloads/release/python-31011/)
## Install Process (cmd\bat)
###### Visual Studio Build Tools 2022
```bat
vs_buildtools.exe --norestart --passive --add Microsoft.VisualStudio.Workload.VCTools --includeRecommended
```
###### Clone TRELLIS Repo
```bat
git clone --recurse-submodules https://github.com/microsoft/TRELLIS.git
CD TRELLIS
```
###### Virtual Environment Setup
```bat
py -3.10 -m venv "trellis-venv"
call trellis-venv\scripts\activate.bat
```
###### Update pip, wheel, setuptools
```bat
python -m pip install --upgrade pip wheel
python -m pip install setuptools==75.8.2
```
###### Requirements Install
```bat
pip install -r requirements-torch.txt
pip install -r requirements-other.txt
```
###### Environment Variables (optional) and app.py launch
```bat
set ATTN_BACKEND=flash-attn
set SPCONV_ALGO=native
set XFORMERS_FORCE_DISABLE_TRITON=1

python ./app.py
```
