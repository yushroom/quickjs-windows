cmake_minimum_required(VERSION 3.11.0)

project(quickjs)

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
target_compile_definitions(quickjs PUBLIC CONFIG_VERSION="2020-04-12")
target_compile_definitions(quickjs PUBLIC _GNU_SOURCE)
target_compile_features(quickjs PUBLIC c_std_11)
# set_target_properties(quickjs PROPERTIES FOLDER "ThirdParty")
if (WIN32)
    target_compile_definitions(quickjs PUBLIC _CRT_SECURE_NO_WARNINGS EMSCRIPTEN)
else ()
    target_sources(quickjs PRIVATE
        ${QUICKJS_ROOT_DIR}/libbf.c
        ${QUICKJS_ROOT_DIR}/libbf.h)
    target_compile_definitions(quickjs PUBLIC CONFIG_BIGNUM)
endif ()

add_executable(qjsc qjsc.c getopt.h getopt.c)
target_link_libraries(qjsc PUBLIC quickjs)

add_executable(qjs qjs.c repl.c)
target_link_libraries(qjs PUBLIC quickjs)