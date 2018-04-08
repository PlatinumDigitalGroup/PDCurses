cmake_minimum_required(VERSION 3.7)
set(CMAKE_TOOLCHAIN_FILE platchain-clang-msvc.cmake)
project(src C)

set(CMAKE_CXX_STANDARD 14)

set(CMAKE_VERBOSE_MAKEFILE ON)

include_directories("${WINDOWS_LIB}um")
include_directories("${MSVC_HOME}include")
include_directories("include/pdcurses")

set(SOURCE_FILES
        src/addch.c
        src/addchstr.c
        src/addstr.c
        src/attr.c
        src/beep.c
        src/bkgd.c
        src/border.c
        src/clear.c
        src/color.c
        src/debug.c
        src/delch.c
        src/deleteln.c
        src/deprec.c
        src/getch.c
        src/getstr.c
        src/getyx.c
        src/inch.c
        src/inchstr.c
        src/initscr.c
        src/inopts.c
        src/insch.c
        src/insstr.c
        src/instr.c
        src/kernel.c
        src/keyname.c
        src/mouse.c
        src/move.c
        src/outopts.c
        src/overlay.c
        src/pad.c
        src/panel.c
        src/printw.c
        src/refresh.c
        src/scanw.c
        src/scr_dump.c
        src/scroll.c
        src/slk.c
        src/termattr.c
        src/terminfo.c
        src/touch.c
        src/util.c
        src/window.c
        src/pdcclip.c
        src/pdcdisp.c
        src/pdcgetsc.c
        src/pdckbd.c
        src/pdcscrn.c
        src/pdcsetsc.c
        src/pdcutil.c
        include/pdcurses/pdcwin.h
        include/pdcurses/curses.h
        include/pdcurses/curspriv.h
        include/pdcurses/panel.h
        include/pdcurses/term.h)

add_library(src ${SOURCE_FILES})