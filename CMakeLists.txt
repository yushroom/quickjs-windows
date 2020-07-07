cmake_minimum_required(VERSION 3.11.0)

project(quickjs)

option(USE_BIGNUM "use bignum" OFF)

set(QUICKJS_ROOT_DIR "${CMAKE_CURRENT_LIST_DIR}")
add_library(quickjs
    ${QUICKJS_ROOT_DIR}/cutils.c
    ${QUICKJS_ROOT_DIR}/cutils.h
    ${QUICKJS_ROOT_DIR}/libregexp.c
    ${QUICKJS_ROOT_DIR}/libregexp.h
    ${QUICKJS_ROOT_DIR}/libunicode.c
    ${QUICKJS_ROOT_DIR}/libunicode.h
    ${QUICKJS_ROOT_DIR}/list.h
    ${QUICKJS_ROOT_DIR}/quickjs-atom.h
    ${QUICKJS_ROOT_DIR}/quickjs-libc.c
    ${QUICKJS_ROOT_DIR}/quickjs-libc.h
    ${QUICKJS_ROOT_DIR}/quickjs-opcode.h
    ${QUICKJS_ROOT_DIR}/quickjs.c
    ${QUICKJS_ROOT_DIR}/quickjs.h
)

target_include_directories(quickjs PUBLIC ${QUICKJS_ROOT_DIR})
target_compile_definitions(quickjs PUBLIC CONFIG_VERSION="2020-07-05")
target_compile_definitions(quickjs PUBLIC _GNU_SOURCE)
target_compile_features(quickjs PUBLIC c_std_11)

if (WIN32)
    target_sources(quickjs PRIVATE
        ${QUICKJS_ROOT_DIR}/sys_time.h
        ${QUICKJS_ROOT_DIR}/gettimeofday.c)
    target_compile_definitions(quickjs PUBLIC _CRT_SECURE_NO_WARNINGS EMSCRIPTEN)
endif()

if (USE_BIGNUM)
    target_sources(quickjs PRIVATE
        ${QUICKJS_ROOT_DIR}/libbf.c
        ${QUICKJS_ROOT_DIR}/libbf.h)
    target_compile_definitions(quickjs PUBLIC CONFIG_BIGNUM=1)
endif ()

add_executable(qjsc qjsc.c getopt.h getopt.c)
target_link_libraries(qjsc PUBLIC quickjs)

if (EXISTS ${QUICKJS_ROOT_DIR}/repl.c)
    add_executable(qjs qjs.c repl.js repl.c)
    target_link_libraries(qjs PUBLIC quickjs)

    if (EXISTS ${QUICKJS_ROOT_DIR}/qjscalc.c)
        target_sources(qjs PRIVATE qjscalc.js qjscalc.c)
    endif()
endif()