function(find_vcpkg_install_missing pkg_name) #vcpkg_name
    #message("ARGV1 ${ARGV1}")
    find_package(${pkg_name} CONFIG QUIET)
    if (${${pkg_name}_FOUND})
        message("find_vcpkg_install_missing ${pkg_name} found")
    else ()
        if (NOT DEFINED CMAKE_TOOLCHAIN_FILE)
            message(FATAL_ERROR "package not found and no CMAKE_TOOLCHAIN_FILE")
        else ()
            if ("${ARGV1}" STREQUAL "")
                set (vcpkg_name ${pkg_name})
            else ()
                set (vcpkg_name ${ARGV1})
            endif ()
            # message("${CMAKE_TOOLCHAIN_FILE}") d:/dev/vcpkg/scripts/buildsystems/vcpkg.cmake
            cmake_path(SET vcpkg_exe NORMALIZE "${CMAKE_TOOLCHAIN_FILE}/../../../vcpkg")
            if (WIN32)
                set (vcpkg_exe "${vcpkg_exe}.exe")
            endif()
            execute_process(COMMAND "${vcpkg_exe}" "install" "${vcpkg_name}" RESULT_VARIABLE res)
            if (NOT ${res} EQUAL 0)
                message(FATAL_ERROR "vcpkg failed with result {res}")
            endif()
            find_package(${pkg_name} CONFIG REQUIRED)
        endif()
    endif()
endfunction()

function(vcpkg_install vcpkg_name)
    if (NOT DEFINED CMAKE_TOOLCHAIN_FILE)
        message(FATAL_ERROR "package not found and no CMAKE_TOOLCHAIN_FILE")
    else ()
        cmake_path(SET vcpkg_exe NORMALIZE "${CMAKE_TOOLCHAIN_FILE}/../../../vcpkg")
        if (WIN32)
            set (vcpkg_exe "${vcpkg_exe}.exe")
        endif()
        message("COMMAND ${vcpkg_exe} install ${vcpkg_name}")
        execute_process(COMMAND "${vcpkg_exe}" "install" "${vcpkg_name}" RESULT_VARIABLE res)
        if (NOT ${res} EQUAL 0)
            message(FATAL_ERROR "vcpkg failed with result ${res}")
        endif()
    endif()
endfunction()
