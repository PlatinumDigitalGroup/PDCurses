# Copyright (c) 2017 Platinum Digital Group LLC
# CMake toolchain that targets Windows, uses Clang++ to compile, and MSVC to link
#
# Set TARGET_ARCHITECTURE to i686 to build for x86
# Set TARGET_ARCHITECTURE to x86_64 to build for x86_64

# Set compiler ID
set(CMAKE_C_COMPILER_ID_RUN TRUE)
set(CMAKE_C_COMPILER_ID Clang)
set(CMAKE_C_COMPILER_VERSION "4.0.0")
set(CMAKE_C_STANDARD_COMPUTED_DEFAULT 98)
set(CMAKE_CXX_COMPILER_ID_RUN TRUE)
set(CMAKE_CXX_COMPILER_ID Clang)
set(CMAKE_CXX_COMPILER_VERSION "4.0.0")
set(CMAKE_CXX_STANDARD_COMPUTED_DEFAULT 14)

# Set the default arch to x86
if(NOT DEFINED TARGET_ARCHITECTURE)
    set(TARGET_ARCHITECTURE "i686")
endif()

# Set the target
set(CMAKE_SYSTEM_NAME Generic)
set(CMAKE_SYSTEM_PROCESSOR "${TARGET_ARCHITECTURE}")
set(triple ${TARGET_ARCHITECTURE}-w64-windows-msvc)

# Set the linker arch
if(${TARGET_ARCHITECTURE} STREQUAL "i686")
    set(LINKER_ARCH "X86")
else()
    set(LINKER_ARCH "X64")
    message("${TARGET_ARCHITECTURE}")
endif()

# Set up some default variables
set(CLANG_HOME "C:/Program Files/LLVM/bin/")
set(MSVC_HOME "C:/Program Files (x86)/Microsoft Visual Studio 14.0/VC/")
set(MSVC_BIN "${MSVC_HOME}bin/")
set(WINDOWS_LIB "C:/Program Files (x86)/Windows Kits/10/Include/10.0.16299.0/")

# Add MSVC home to PATH so that CMake can find it
# This *should* be set with CMAKE_LINKER however that is blanked for some reason
# set(ENV{PATH} "${MSVC_BIN}:$ENV{PATH}")
list(APPEND CMAKE_PROGRAM_PATH  "${MSVC_BIN}")

# The CMake compile test cannot handle cross-compiler linking, so use this flag to avoid it
# set(CMAKE_TRY_COMPILE_TARGET_TYPE STATIC_LIBRARY)

# Set sysroot to mingw32
# DEPRECATED do not use
# set(CMAKE_SYSROOT "${MSVC_BIN}")

# Tell CMake to treat our compiler as if it was GNU
# Use ONLY if you must use clang++ instead of clang-cl
# include(CMakeForceCompiler)
# CMAKE_FORCE_C_COMPILER(triple Clang)
# CMAKE_FORCE_CXX_COMPILER(triple Clang)

# Set compilers to clang
set(CMAKE_C_COMPILER "${CLANG_HOME}clang.exe")
set(CMAKE_C_COMPILER_TARGET ${triple})
set(CMAKE_CXX_COMPILER "${CLANG_HOME}clang++.exe")
set(CMAKE_CXX_COMPILER_TARGET ${triple})

# Set rc and mt to msvc
set(CMAKE_RC_COMPILER "${MSVC_BIN}/rc")
set(CMAKE_MT_COMPILER "${MSVC_BIN}/mt")

# Set the linker to MSVC
set(CMAKE_LINKER  "${MSVC_BIN}link.exe")

# Set archive to msvc link
set(CMAKE_CXX_ARCHIVE_CREATE "<CMAKE_LINKER> <LINK_FLAGS> /out:<TARGET> <OBJECTS>")
set(CMAKE_C_ARCHIVE_CREATE "<CMAKE_LINKER> <LINK_FLAGS> /out:<TARGET> <OBJECTS>")

# Set conditional linker flags
set(CMAKE_STATIC_LINKER_FLAGS "${CMAKE_STATIC_LINKER_FLAGS} /lib /MACHINE:${LINKER_ARCH} /libpath:\"${MSVC_HOME}/lib/amd64\"")
set(CMAKE_MODULE_LINKER_FLAGS CMAKE_STATIC_LINKER_FLAGS)
set(CMAKE_SHARED_LINKER_FLAGS CMAKE_STATIC_LINKER_FLAGS)
set(CMAKE_EXE_LINKER_FLAGS CMAKE_STATIC_LINKER_FLAGS)
