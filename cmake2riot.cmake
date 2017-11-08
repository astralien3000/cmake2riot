


macro(add_executable target)

    message("[cmake2riot] executing custom add_executable command")
    file(MAKE_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/cmake2riot/${target})

    set(${target}_sources "")
    foreach(arg ${ARGN})
        set(src_file ${CMAKE_CURRENT_SOURCE_DIR}/${arg})
        set(dst_file ${CMAKE_CURRENT_BINARY_DIR}/cmake2riot/${target}/${arg})
        configure_file(${src_file} ${dst_file} COPYONLY)
        set(${target}_sources ${${target}_sources} ${dst_file})
    endforeach(arg)

    set(MAKEFILE_PATH "${CMAKE_CURRENT_BINARY_DIR}/cmake2riot/${target}/Makefile")
    file(WRITE  "${MAKEFILE_PATH}" "APPLICATION = ${target}\n")
    file(APPEND "${MAKEFILE_PATH}" "RIOTBASE ?= $ENV{HOME}/RIOT\n")
    file(APPEND "${MAKEFILE_PATH}" "BOARD = native\n")
    file(APPEND "${MAKEFILE_PATH}" "QUIET ?= 1\n")
    file(APPEND "${MAKEFILE_PATH}" "WERROR ?= 0\n")
    file(APPEND "${MAKEFILE_PATH}" "include $(RIOTBASE)/Makefile.include\n")

    add_custom_target(
        ${target} ALL "make"
        DEPENDS ${${target}_sources} ${MAKEFILE_PATH}
        WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/cmake2riot/${target}
        )

endmacro()


macro(install)

    message("[cmake2riot] executing custom install command")

    set(target_kinds
        ARCHIVE LIBRARY RUNTIME FRAMEWORK BUNDLE
        PRIVATE_HEADER PUBLIC_HEADER RESOURCE
        )

    set(options "")
    set(oneValueArgs EXPORT)
    set(multiValueArgs TARGETS ${target_kinds})
    cmake_parse_arguments(install_args "${options}" "${oneValueArgs}" "${multiValueArgs}" ${ARGN})

    set(unsupported_kinds
        ARCHIVE LIBRARY RUNTIME FRAMEWORK BUNDLE
        PRIVATE_HEADER PUBLIC_HEADER RESOURCE
        )
    foreach(kind in ${unsupported_kinds})
        if(install_args_${kind})
            message(WARNING "[cmake2riot] ${kind} argument is not supported")
        endif()
    endforeach(kind)

    foreach(target ${install_args_TARGETS})
        message(${target})
        _install(
            PROGRAMS ${CMAKE_CURRENT_BINARY_DIR}/cmake2riot/${target}/bin/native/${target}.elf
            DESTINATION bin
            )
    endforeach(target)

endmacro()
